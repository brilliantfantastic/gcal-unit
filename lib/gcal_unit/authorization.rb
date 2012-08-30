module Google
  # Public: API methods to authorize a specific user for
  # the API calls.
  class Authorization < Client
    base_uri 'https://accounts.google.com'

    # Public: Returns a new access token for a specific refresh token.
    #
    # Returns a hash of metadata for refreshed user access.
    def refresh
      options = {
        :body => {
          :client_id => Google.configuration.client_id,
          :client_secret => Google.configuration.client_secret,
          :refresh_token => @token,
          :grant_type => 'refresh_token'
        },
        :headers => {
          'Content-Type' => 'application/x-www-form-urlencoded'
        }
      }
      http_post "/o/oauth2/token", options
    end
  end
end
