require 'heroku/command/run'
require 'exporter'
require 'importer'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '../../../vendor/json_pure/lib'))
require 'json/pure'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Run

  def import
    puts 'Import'
    json = File.read('heroku.json')
    json = JSON.parse(json)
    importer = Importer.new(api, app, json)
    importer.import
  end

  alias_command 'import', 'json:import'

  def export
    exporter = Exporter.new(api, app)
    json = exporter.export
    File.write('heroku.json', JSON.pretty_generate(json))
  end

  alias_command 'export', 'json:export'

end

