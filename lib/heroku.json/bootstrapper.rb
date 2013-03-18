module HerokuJson
  class Bootstrapper < Struct.new(:api, :app, :json, :create_app_func)
    include Heroku::Helpers

    def bootstrap
      self.app = create_app_func.call if app.nil?
      add_addons
      add_config_vars
    end

    private

    def create_app_if_not_exists

    end

    def add_addons
      json['addons'].each do |addon|
        action "Installing addon #{addon}" do
          begin
            api.post_addon(app, addon)
          rescue Heroku::API::Errors::RequestFailed => e
            status("already installed")
          end
        end
      end
    end

    def add_config_vars
      action "Deploying environment configs" do
        api.put_config_vars(app, json['env'])
      end
    end

    def push_code

    end

    def run_custom_commands

    end
  end
end