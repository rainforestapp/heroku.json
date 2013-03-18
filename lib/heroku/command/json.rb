require 'heroku/command/run'
require 'heroku.json/api_helper'
require 'describer'
require 'bootstrapper'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '../../../vendor/json_pure/lib'))
require 'json/pure'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Run

  def bootstrap
    Heroku::Helpers.display_header("Bootstrapping using heroku.json")
    json = File.read('heroku.json')
    json = JSON.parse(json)
    bootstrapper = Bootstrapper.new(api, safe_app, json)
    bootstrapper.bootstrap
  end

  alias_command 'bootstrap', 'json:bootstrap'

  def describe
    Heroku::Helpers.display_header("Describing #{app} to heroku.json")
    describer = Describer.new(api, app)
    json = describer.describe
    File.write('heroku.json', JSON.pretty_generate(json))
  end

  alias_command 'describe', 'json:describe'

  private
  def safe_app
    begin
      app
    rescue Heroku::Command::CommandFailed
      nil
    end
  end

end

