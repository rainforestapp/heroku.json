require 'heroku/command/run'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Run

  def import
    puts 'Import'
  end

  alias_command 'import', 'json:import'

  def export 
    puts 'Export'
  end
  alias_command 'export', 'json:export'
end

