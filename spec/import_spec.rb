require 'spec_helper'

describe "#import" do
  let(:user) { ENV['HEROKU_USER'] }
  let(:password) { ENV['HEROKU_PASSWORD'] }
  let(:client) { Heroku::Client.new(user, password) }
  let(:command) { Heroku::Command::Json.new }

  it "import stuff" do
    command.import
  end
end
