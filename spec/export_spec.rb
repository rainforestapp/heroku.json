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

  context "environment variable" do

    it "ignores blacklisted variables"

    it "copies whitelisted variables"

    it "prompts for all non-white/black listed variables"

  end
end
