module HerokuJson
  module ApiHelper
    def body_or_die res
      Heroku::Helpers.error("API request to Heroku failed with status #{res.status}. Aborted.") unless res.status == 200
      res.body
    end

    def app_addons
      Heroku::Helpers.action "Getting addons for #{app}" do
        body_or_die(api.get_addons(app)).map { |h| h['name'] }
      end
    end
  end
end
