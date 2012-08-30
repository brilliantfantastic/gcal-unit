require 'spec_helper'

describe Google::Event do
  let(:client) { Google::Event.new(token) }
  let(:event) do
    {
      end: { date: (Date.today + 1).strftime("%Y-%m-%d") },
      start: { date: Date.today.strftime("%Y-%m-%d") }
    }
  end

  describe ".update" do
    it "should raise an error if the calendar id was not provided" do
      expect { client.update(nil, nil) }.to raise_error Google::CalendarRequiredError
    end

    context "needs an existing event" do
      before :all do
        VCR.use_cassette "event_insert_success" do
          @event = client.nested_for('primary').insert event
        end
      end

      after :all do
        VCR.use_cassette "event_delete_success" do
          client.nested_for('primary').delete @event['id']
        end
      end

      context "has a calendar" do
        use_vcr_cassette "event_update_success"
        
        it "should change the event when the data is valid" do
          @event['description'] = "This has changed"
          response = client.nested_for('primary').update(@event['id'], @event)
          response['description'].should == "This has changed"
        end
      end
    end
  end

  describe ".list" do
    it "should raise an error if the calendar id was not provided" do
      expect { client.list }.to raise_error Google::CalendarRequiredError
    end

    context "without a token" do
      use_vcr_cassette "authentication_needed"
      it "should raise an error if authentication is needed" do
        expect { Google::Event.new('').nested_for('primary').list }.to raise_error Google::AuthenticationRequiredError
      end
    end

    context "with a token" do
      use_vcr_cassette "event_list_success"
      it "should return a list of events" do
        client.nested_for('primary').list['kind'].should == 'calendar#events'
      end
    end
  end

  describe ".get" do
    it "should raise an error if the calendar id was not provided" do
      expect { client.get(nil) }.to raise_error Google::CalendarRequiredError
    end

    context "needs an existing event" do
      before :all do
        VCR.use_cassette "event_insert_success" do
          @event = client.nested_for('primary').insert event
        end
      end

      after :all do
        VCR.use_cassette "event_delete_success" do
          client.nested_for('primary').delete @event['id']
        end
      end

      context "with a calendar" do
        use_vcr_cassette "event_get_success"
        it "should return a single event" do
          client.nested_for('primary').get(@event['id'])['kind'].should == 'calendar#event'
        end
      end
    end
  end

  describe ".delete" do
    it "should raise an error if the calendar id was not provided" do
      expect { client.delete(nil) }.to raise_error Google::CalendarRequiredError
    end

    context "needs an existing event" do
      before :all do
        VCR.use_cassette "event_insert_success" do
          @event = client.nested_for('primary').insert event
        end
      end

      context "has a calendar" do
        use_vcr_cassette "event_delete_success"
        it "should delete an event by id" do
          client.nested_for('primary').delete(@event['id']).code.should == 204
        end
      end
    end
  end

  describe ".insert" do
    it "should raise an error if the calendar id was not provided" do
      expect { client.insert(nil) }.to raise_error Google::CalendarRequiredError
    end

    context "with a calendar" do
      use_vcr_cassette "event_insert_success"
      it "should insert a new event when the data is valid" do
        response = client.nested_for('primary').insert(event)
        response['kind'].should == 'calendar#event'
        client.nested_for('primary').delete response['id'] # clean up
      end
    end
  end

  describe ".quickAdd" do
    use_vcr_cassette "event_quickadd_success"

    it "should raise an error if the calendar id was not provided" do
      expect { client.quick_add(nil) }.to raise_error Google::CalendarRequiredError
    end

    it "should insert a new event when the data is valid" do
      response = client.nested_for('primary').quick_add("meet Jimmy today at 1pm")
      response['kind'].should == 'calendar#event'
      client.nested_for('primary').delete response['id'] # clean up
    end
  end
end
