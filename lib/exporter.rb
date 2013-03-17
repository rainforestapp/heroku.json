class Exporter < Struct.new(:api, :app)
  def export
    {
      'addons' => app_addons
    }
  end

  private
  def app_addons
    api.get_addons(app).body.map{|h| h['name']}
  end
end
