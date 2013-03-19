module HerokuJson
  class Describer < Struct.new(:api, :app)
    include Heroku::Helpers

    def describe
      {
          'addons' => app_addons,
          'env' => app_environment_variables
      }
    end

    private

    def app_addons
      action "Getting addons for #{app}" do
        body_or_die(api.get_addons(app)).map { |h| h['name'] }
      end
    end

    def app_environment_variables
      env = {}

      action "Getting environment variables #{app}" do
        body_or_die(api.get_config_vars(app)).each do |key, value|
          # Skip if it's blacklisted
          next if Array(HerokuJson::ENV_BLACKLIST).map { |re| Regexp.new(re).match(key) }.compact.first

          env[key] = value
        end
      end

      ksort env
    end

    def body_or_die res
      error("API request to Heroku failed with status #{res.status}. Aborted.") unless res.status == 200
      res.body
    end

    def ksort h
      out = {}
      h.keys.sort.each do |k|
        out[k] = h[k]
      end
      out
    end
  end
end