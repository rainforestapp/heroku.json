require 'spec_helper'

describe Importer do
  let(:app) { 'foo' }
  let(:sample_json) { {'addons' => ['addon1', 'addon2'], 'env' => {'ENV1' => '1', 'ENV2' => 2}} }
  let(:api) { stub(:post_addon => true, :put_config_vars => true) }

  describe "#import" do
    it "install all addons" do
      importer = Importer.new(api, app, sample_json)

      api.should_receive(:post_addon).with(app, 'addon1')
      api.should_receive(:post_addon).with(app, 'addon2')

      importer.import
    end
    it "set all environment variables" do
      importer = Importer.new(api, app, sample_json)

      api.should_receive(:put_config_vars).with(app, sample_json['env'])

      importer.import
    end
  end
end
