class Exporter < Struct.new(:api, :app)
  def export
    {
        'addons' => app_addons,
        'env' => app_environment_variables
    }
  end

  private

  def app_addons
    body_or_die(api.get_addons(app)).map { |h| h['name'] }
  end

  def app_environment_variables
    env = {
        whitelist: {},
        to_query: {},
    }

    body_or_die(api.get_config_vars(app)).each do |key, value|
      # Skip if it's blacklisted
      next if HerokuJson::ENV_BLACKLIST.include?(key)

      # Put it in the right place for querying later
      if HerokuJson::ENV_WHITELIST.include?(key)
        env[:whitelist][key] = value
      else
        env[:to_query][key] = value
      end

    end

    env
  end

  def body_or_die res
    raise "Fail getting env : #{res.status}" unless res.status == 200
    res.body
  end
end
