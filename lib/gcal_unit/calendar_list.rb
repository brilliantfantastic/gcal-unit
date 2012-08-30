module Google
  # Public: API methods for a list of calendars.
  class CalendarList < Client
    # Public: Gets a list of calendars for the user specified
    # with the provided token.
    #
    # Returns a hash of metadata for a calendar list.
    def list
      response = http_get '/users/me/calendarList'
      JSON.parse response.body
    end
  end
end
