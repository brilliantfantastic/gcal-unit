require 'spec_helper'

describe Google::Authorization do
  let(:client) { Google::Authorization.new(Google.configuration.refresh_token) }

  describe ".refresh" do
    use_vcr_cassette "authorization_success"
    it "should return a new access token" do
      client.refresh()['access_token'].should_not be_nil
    end
  end
end
