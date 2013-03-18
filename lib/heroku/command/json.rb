$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '../../../vendor/json_pure/lib'))
require 'herokujson/api_helper'
require 'heroku/command/run'
require 'herokujson/describer'
require 'herokujson/bootstrapper'
require 'json/pure'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Run
  include Heroku::Helpers

  def bootstrap
    display_header("Bootstrapping using heroku.json")
    json = File.read('heroku.json')
    json = JSON.parse(json)

    display
    display_table(json['addons'], json['addons'], ['Addons'])

    if confirm_billing
      bootstrapper = HerokuJson::Bootstrapper.new(api, safe_app, json, lambda { create_app })
      bootstrapper.bootstrap
    end
  end

  alias_command 'bootstrap', 'json:bootstrap'

  def describe
    display_header("Describing #{app} to heroku.json")
    describer = HerokuJson::Describer.new(api, app)
    json = describer.describe
    File.open('heroku.json','w') do |f|
      f.write(JSON.pretty_generate(json))
    end
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

