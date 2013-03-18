class Bootstrapper < Struct.new(:api, :app, :json)
  include HerokuJson::ApiHelper

  def bootstrap
    self.app = create_app if app.nil?
    add_addons
    add_config_vars
  end

  private

  def create_app
    require 'heroku/command/apps'
    Heroku::Command.prepare_run 'create'
    cmd = Heroku::Command::Apps.new
    cmd.create
    cmd.app
  end

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
end
