require 'heroku/command/run'

# invoke commands without fucking "run"
class Heroku::Command::Json < Heroku::Command::Run

  def import
    puts 'Import'
  end

  def export 
    puts 'Export'
  end
end

