require 'heroku/command/run'
require 'describer'
require 'bootstrapper'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '../../../vendor/json_pure/lib'))
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
      bootstrapper = Bootstrapper.new(api, app, json)
      bootstrapper.bootstrap
    end
  end

  alias_command 'bootstrap', 'json:bootstrap'

  def describe
    display_header("Describing #{app} to heroku.json")
    describer = Describer.new(api, app)
    json = describer.describe
    File.write('heroku.json', JSON.pretty_generate(json))
  end

  alias_command 'describe', 'json:describe'

end

