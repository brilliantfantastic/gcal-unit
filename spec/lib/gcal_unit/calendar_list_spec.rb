require 'spec_helper'

describe Google::CalendarList do
  let(:client) { Google::CalendarList.new(token) }

  describe ".list" do
    context "without a token" do
      use_vcr_cassette "authentication_needed"
      it "should raise an error if authentication is needed" do
        expect { Google::CalendarList.new(nil).list }.to raise_error Google::AuthenticationRequiredError
      end
    end

    context "with a token" do
      use_vcr_cassette "calendar_list_success"
      it "should return a list of calendars for the authorized user" do
        client.list["items"].count.should > 0
      end
    end
  end
end
