require 'spec_helper'

describe "#export" do
  let(:user) { ENV['HEROKU_USER'] }
  let(:password) { ENV['HEROKU_PASSWORD'] }
  let(:client) { Heroku::Client.new(user, password) }
  let(:command) { Heroku::Command::Json.new }

  it "does stuff" do
    puts client.list

    command.export
  end
end
