require 'heroku/command/run'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Run

  def import
    puts 'Import'
  end
  alias_command 'import', 'json:import'

  def export
    puts 'Export'
    puts api.get_apps.body.map {|h| h['name'] }
    puts api.get_app(app).body
    puts api.get_addons(app).body.map{|h| h['name']}
  end
  alias_command 'export', 'json:export'
end

