require 'spec_helper'
require 'heroku-api'

describe Bootstrapper do
  let(:app) { 'foo' }
  let(:sample_json) { {'addons' => ['addon1:small', 'addon2:nano'], 'env' => {'ENV1' => '1', 'ENV2' => 2}} }
  let(:bootstrapper) { Bootstrapper.new(api, app, sample_json) }
  let(:response) { OpenStruct.new(:status => 200, :body => [])}
  let(:api) { stub(:post_addon => response, :put_config_vars => response, :get_addons => response) }

  describe "#bootstrap" do
    it "install all addons" do
      api.should_receive(:post_addon).with(app, 'addon1:small')
      api.should_receive(:post_addon).with(app, 'addon2:nano')
      bootstrapper.bootstrap
    end

    it "install all addons that are not installed" do
      bootstrapper.stub :app_addons => ["addon1:large"]
      api.should_not_receive(:post_addon).with(app, 'addon1:small')
      api.should_receive(:post_addon).with(app, 'addon2:nano')
      bootstrapper.bootstrap
    end

    it "handles already instaled addons" do
      api.should_receive(:post_addon).and_raise(Heroku::API::Errors::RequestFailed.new(nil,nil))
      bootstrapper.bootstrap
    end

    it "set all environment variables" do
      api.should_receive(:put_config_vars).with(app, sample_json['env'])
      bootstrapper.bootstrap
    end
  end
end
