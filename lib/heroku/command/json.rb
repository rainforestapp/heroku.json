require 'heroku/command/run'
require 'exporter'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Run

  def import
    puts 'Import'
  end

  alias_command 'import', 'json:import'

  def export
    exporter = Exporter.new(api, app)
    json = exporter.export
    File.write('heroku.json', JSON.pretty_generate(json))
  end

  alias_command 'export', 'json:export'

end

