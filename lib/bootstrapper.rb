class Bootstrapper < Struct.new(:api, :app, :json)
  include HerokuJson::ApiHelper

  def bootstrap
    # create_app_if_not_exists
    add_addons
    add_config_vars
    # push_code
    # run_custom_commands
  end

  private

  def create_app_if_not_exists

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
          Heroku::Helpers.display "Addon #{addon} is already installed"
        end
      end
    end
  end

  def add_config_vars
    Heroku::Helpers.action "Deploying environment configs" do
      api.put_config_vars(app, json['env'])
    end
  end

  def push_code

  end

  def run_custom_commands

  end
end
