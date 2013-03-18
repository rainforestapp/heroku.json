require 'heroku/command/run'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '../../../vendor/json_pure/lib'))
require 'heroku.json/api_helper'
require 'describer'
require 'bootstrapper'
require 'json/pure'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Base

  def bootstrap
    Heroku::Helpers.display_header("Bootstrapping using heroku.json")
    json = File.read('heroku.json')
    json = JSON.parse(json)
    bootstrapper = Bootstrapper.new(api, safe_app, json, lambda { create_app })
    #Heroku::Helpers.confirm_billing
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

  def create_app
    require 'heroku/command/apps'

    name    = shift_argument || options[:app] || ENV['HEROKU_APP']
    validate_arguments!
    
    Heroku::Command.prepare_run name.nil? ? "create" : "create #{name}"
    cmd = Heroku::Command::Apps.new
    cmd.create
    cmd.app
  end

end

