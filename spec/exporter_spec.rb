require 'spec_helper'

describe Exporter do
  let(:app) { 'my_app' }
  let(:sample_get_addons) { 
    [
      {"name"=>"scheduler:standard", "description"=>"Heroku Scheduler Standard", "url"=>nil, "beta"=>false, "state"=>"public", "attachable"=>false, "price"=>{"cents"=>0, "unit"=>"month"}, "slug"=>"standard", "terms_of_service"=>false, "consumes_dyno_hours"=>true, "plan_description"=>"Standard", "group_description"=>"Scheduler", "selective"=>true, "sso_url"=>"https://api.heroku.com/apps/activeblogr/addons/scheduler", "configured"=>true},
      {"name"=>"sendgrid:starter", "description"=>"SendGrid Starter", "url"=>nil, "beta"=>false, "state"=>"public", "attachable"=>false, "price"=>{"cents"=>0, "unit"=>"month"}, "slug"=>"starter", "terms_of_service"=>false, "consumes_dyno_hours"=>false, "plan_description"=>"Starter", "group_description"=>"Sendgrid", "selective"=>true, "sso_url"=>"https://api.heroku.com/apps/activeblogr/addons/sendgrid", "configured"=>true},
      {"name"=>"heroku-postgresql:dev", "description"=>"Heroku Postgres Dev", "url"=>nil, "beta"=>false, "state"=>"public", "attachable"=>true, "price"=>{"cents"=>0, "unit"=>"month"}, "slug"=>"dev", "terms_of_service"=>false, "consumes_dyno_hours"=>false, "plan_description"=>"Dev", "group_description"=>"Heroku Postgresql", "selective"=>false, "sso_url"=>nil, "attachment_name"=>"HEROKU_POSTGRESQL_GRAY", "configured"=>true}
    ]
  }

  let(:sample_get_addons_response) { 
    OpenStruct.new(:body => sample_get_addons)
  }

  let(:api) do 
    stub(
      :get_addons => sample_get_addons_response
    )
  end

  subject do
    Exporter.new(api, app)
  end

  describe "#export" do
    it "Exports the addons" do
      json = subject.export
      json['addons'].should == ["scheduler:standard", "sendgrid:starter", "heroku-postgresql:dev"]
    end
  end
end

