module Google
  # Public: Holds the configuration options for accessing
  # a Google API.
  class Configuration
    attr_accessor :api_key,
      :client_id,
      :client_secret,
      :refresh_token
  end
end
