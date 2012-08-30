module Google
  # Public: API methods for a calendar events.
  class Event < Client
    # Public: Saves a calendar id for methods that require a
    # calendar for the API methods.
    #
    # calendar_id - Identifier for a specific calendar.
    #
    # Returns the event object for chaining
    def nested_for(calendar_id)
      @calendar_id = calendar_id
      self
    end

    # Public: Gets a list of events for a specific calendar.
    #
    # Raises a Google::CalendarRequiredError if a calendar is not
    # supplied (nested_for) was not called.
    #
    # Returns a hash of metadata for the calendars events.
    def list
      raise Google::CalendarRequiredError if @calendar_id.nil?
      response = http_get "/calendars/#{@calendar_id}/events"
      JSON.parse(response.body)
    end

    # Public: Gets a single event.
    #
    # id - The id of the event to retrieve.
    #
    # Raises a Google::CalendarRequiredError if a calendar is not
    # supplied (nested_for) was not called.
    #
    # Returns a hash of metadata for an event.
    def get(id)
      raise Google::CalendarRequiredError if @calendar_id.nil?
      response = http_get "/calendars/#{@calendar_id}/events/#{id}"
      JSON.parse(response.body)
    end

    # Public: Inserts a new single event.
    #
    # event - A hash containing the data for an event to add.
    #
    # Raises a Google::CalendarRequiredError if a calendar is not
    # supplied (nested_for) was not called.
    #
    # Returns a hash of metadata for the event that was added.
    def insert(event)
      raise Google::CalendarRequiredError if @calendar_id.nil?
      response = http_post "/calendars/#{@calendar_id}/events", :body => JSON.dump(event)
      JSON.parse(response.body)
    end

    # Public: Inserts a new single event that is parsed from a line of text.
    #
    # text - A sentence that is parsed into a single event.
    #
    # Raises a Google::CalendarRequiredError if a calendar is not
    # supplied (nested_for) was not called.
    #
    # Returns a hash of metadata for the event that was added.
    def quick_add(text)
      raise Google::CalendarRequiredError if @calendar_id.nil?
      response = http_post "/calendars/#{@calendar_id}/events/quickAdd", :query => { :text => text }
      JSON.parse(response.body)
    end

    # Public: Updates a single event.
    #
    # id - The id of the event to update.
    # event - A hash containing the data for the event to update.
    #
    # Raises a Google::CalendarRequiredError if a calendar is not
    # supplied (nested_for) was not called.
    #
    # Returns a hash of metadata for the event that was updated.
    def update(id, event)
      raise Google::CalendarRequiredError if @calendar_id.nil?
      response = http_put "/calendars/#{@calendar_id}/events/#{id}", :body => JSON.dump(event)
      JSON.parse(response.body)
    end

    # Public: Deletes a single event.
    #
    # id - The id of the event to delete.
    #
    # Raises a Google::CalendarRequiredError if a calendar is not
    # supplied (nested_for) was not called.
    #
    # Returns the response from the delete operation.
    def delete(id)
      raise Google::CalendarRequiredError if @calendar_id.nil?
      http_delete "/calendars/#{@calendar_id}/events/#{id}"
    end
  end
end
