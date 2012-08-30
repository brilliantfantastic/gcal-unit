module Google
  # Public: API methods for a singular calendar.
  class Calendar < Client
    # Public: Gets a single calendar.
    #
    # id - The id of the calendar to retrieve.
    #
    # Returns a hash of metadata for a calendar.
    def get(id)
      response = http_get "/calendars/#{id}"
      JSON.parse(response.body)
    end
  end
end
