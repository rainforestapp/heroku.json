require 'spec_helper'
require 'heroku-api'

describe Importer do
  let(:app) { 'foo' }
  let(:sample_json) { {'addons' => ['addon1', 'addon2'], 'env' => {'ENV1' => '1', 'ENV2' => 2}} }
  let(:importer) { Importer.new(api, app, sample_json) }
  let(:api) { stub(:post_addon => true, :put_config_vars => true) }

  describe "#import" do
    it "install all addons" do
      api.should_receive(:post_addon).with(app, 'addon1')
      api.should_receive(:post_addon).with(app, 'addon2')
      importer.import
    end

    it "handles already instaled addons" do
      api.should_receive(:post_addon).and_raise(Heroku::API::Errors::RequestFailed.new(nil,nil))
      importer.import
    end

    it "set all environment variables" do
      api.should_receive(:put_config_vars).with(app, sample_json['env'])
      importer.import
    end
  end
end
