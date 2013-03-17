class Importer < Struct.new(:api, :app, :json)
  def import
    create_app_if_not_exists
    add_addons
    add_config_vars
    push_code
    run_custom_commands
  end

  private

  def create_app_if_not_exists
    
  end

  def add_addons
    
  end

  def add_config_vars
    
  end

  def push_code
    
  end

  def run_custom_commands
    
  end
end
