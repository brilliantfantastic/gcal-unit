require 'spec_helper'

describe Google::Calendar do
  let(:client) { Google::Calendar.new(token) }

  describe ".get" do
    context "without a token" do
      use_vcr_cassette "authorization_success"
      it "should raise an error if authentication is needed" do
        expect { Google::Calendar.new(nil).get('any_string') }.to raise_error Google::AuthenticationRequiredError
      end
    end

    context "with a token" do
      use_vcr_cassette "calendar_success"
      it "should return a primary google calendar" do
        client.get("primary")["id"].should == ENV['GOOGLE_TEST_USER']
      end
    end
  end
end
