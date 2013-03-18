class Describer < Struct.new(:api, :app)
  include HerokuJson::ApiHelper

  def describe
    {
        'addons' => app_addons,
        'env' => app_environment_variables
    }
  end

  private

  def app_environment_variables
    env = {}

    body_or_die(api.get_config_vars(app)).each do |key, value|
      # Skip if it's blacklisted
      next if HerokuJson::ENV_BLACKLIST.include?(key)

      env[key] = value
    end

    env
  end
end
