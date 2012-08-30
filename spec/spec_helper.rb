require './lib/gcal_unit'
require 'dotenv'
require 'vcr'

def token
  @token
end

def configure
  Google.configure do |config|
    Dotenv.load
    config.api_key = ENV['GOOGLE_API_KEY']
    config.client_id = ENV['GOOGLE_CLIENT_ID']
    config.client_secret = ENV['GOOGLE_CLIENT_SECRET']
    config.refresh_token = ENV['GOOGLE_REFRESH_TOKEN']
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |config|
  config.before(:all) do
    configure
    VCR.use_cassette "authorization_success" do
      # Ensure a new access token before all the specs are run
      client = Google::Authorization.new Google.configuration.refresh_token
      @token = client.refresh()['access_token']
    end
  end
  config.extend VCR::RSpec::Macros
end
