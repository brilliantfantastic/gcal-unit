require 'spec_helper'

describe Google do
  after :all do
    configure
  end

  describe ".configure" do
    it "assigns a value to the api_key" do
      Google.configure do |config|
        config.api_key = '1234'
      end
      Google.configuration.api_key.should == '1234'
    end

    it "assigns a value to the client_id" do
      Google.configure do |config|
        config.client_id = '6789'
      end
      Google.configuration.client_id.should == '6789'
    end

    it "assigns a value to the client_secret" do
      Google.configure do |config|
        config.client_secret = '36748'
      end
      Google.configuration.client_secret.should == '36748'
    end

    it "assigns a value to the refresh_token" do
      Google.configure do |config|
        config.refresh_token = '1009'
      end
      Google.configuration.refresh_token = '1009'
    end
  end
end
