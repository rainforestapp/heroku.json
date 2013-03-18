require 'spec_helper'

describe "#bootstrap" do
  let(:user) { ENV['HEROKU_USER'] }
  let(:password) { ENV['HEROKU_PASSWORD'] }
  let(:client) { Heroku::Client.new(user, password) }
  let(:command) { Heroku::Command::Json.new }

  it "bootstrap stuff" do
    ENV.delete 'HEROKU_APP'
    command.bootstrap
  end
end
