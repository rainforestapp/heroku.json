module HerokuJson
  class Bootstrapper < Struct.new(:api, :app, :json, :create_app_func)
  include HerokuJson::ApiHelper

  def bootstrap
    run_scripts 'before_bootstrap'
    self.app = create_app_func.call if app.nil?
    add_addons
    add_config_vars
    run_scripts 'after_bootstrap'
  end

  private

  def add_addons
    installed_addons = app_addons.map {|a| a.split(':').first }
    json['addons'].each do |addon|
      name, size = addon.split(':')
      next if installed_addons.include?(name)
      Heroku::Helpers.action "Installing addon #{addon}" do
        begin
          api.post_addon(app, addon)
        rescue Heroku::API::Errors::RequestFailed => e
          Heroku::Helpers.status("already installed")
        end
      end
    end
  end

  def add_config_vars
    Heroku::Helpers.action "Deploying environment configs" do
      api.put_config_vars(app, json['env'])
    end
  end

  def run_scripts(key)
    if json[key].nil?
      return
    end

    json[key].each do |script|
      system script
    end
  end
end
end
