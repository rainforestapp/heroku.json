require 'spec_helper'

describe Importer do
  let(:app) { 'foo' }


  describe "#import" do
    it "install all addons" do
      json = {'addons' => ['addon1', 'addon2']}
      api = stub()
      exporter = Importer.new(api, app, json)

      api.should_receive(:post_addon).with(app, 'addon1')
      api.should_receive(:post_addon).with(app, 'addon2')

      exporter.import
    end
  end  
end
