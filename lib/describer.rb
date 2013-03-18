class Describer < Struct.new(:api, :app)
  def describe
    {
        'addons' => app_addons,
        'env' => app_environment_variables
    }
  end

  private

  def app_addons
    Heroku::Helpers.action "Getting addons for #{app}" do
      body_or_die(api.get_addons(app)).map { |h| h['name'] }
    end
  end

  def app_environment_variables
    env = {}

    Heroku::Helpers.action "Getting environment variables #{app}" do
      body_or_die(api.get_config_vars(app)).each do |key, value|
        # Skip if it's blacklisted
        next if Array(HerokuJson::ENV_BLACKLIST).map { |re| Regexp.new(re).match(key) }.compact.first

        env[key] = value
      end
    end

    env
  end

  def body_or_die res
    raise "Fail getting env : #{res.status}" unless res.status == 200
    res.body
  end
end
