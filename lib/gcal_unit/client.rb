module Google
  # Public : Performs http calls to the Google APIs.
  class Client
    include HTTParty
    base_uri 'https://www.googleapis.com/calendar/v3'

    # Public: Initializes a new instance of a client.
    #
    # token - The user token to make the call.
    def initialize(token)
      @token = token
    end

    # Public: Performs a GET request for an http call with the correct queries
    # and headers applied.
    #
    # path - the url for the GET request
    # options - additional options for the GET request
    # block - called after the GET request is complete
    #
    # Raises Google::AuthenticationRequiredError if the token is no longer valid
    #
    # Returns the response
    def http_get(path, options={}, &block)
      apply_api_key options # apply the API key if it is not there
      apply_auth_header options # apply the authorization header if it is not there

      response = self.class.get path, options, &block
      raise AuthenticationRequiredError.new if response.code == 401
      response
    end

    # Public: Performs a POST request for an http call with the correct queries
    # and headers applied.
    #
    # path - the url for the POST request
    # options - additional options for the POST request
    # block - called after the POST request is complete
    #
    # Raises Google::AuthenticationRequiredError if the token is no longer valid
    #
    # Returns the response
    def http_post(path, options={}, &block)
      apply_api_key options # apply the API key if it is not there
      apply_auth_header options # apply the authorization header if it is not there
      apply_content_type_header options
      apply_content_length_header options

      response = self.class.post path, options, &block
      raise AuthenticationRequiredError.new if response.code == 401
      response
    end

    # Public: Performs a PUT request for an http call with the correct queries and
    # headers applied.
    #
    # path - the url for the PUT request
    # options - additional options for the PUT request
    # block - called after the PUT request is complete
    #
    # Raises Google::AuthenticationRequiredError if the token is no longer valid
    #
    # Returns the response
    def http_put(path, options={}, &block)
      apply_api_key options # apply the API key if it is not there
      apply_auth_header options # apply the authorization header if it is not there
      apply_content_type_header options

      response = self.class.put path, options, &block
      raise AuthenticationRequiredError.new if response.code == 401
      response
    end

    # Public: Performs a DELETE request for an http call with the correct queries and
    # headers applied.
    #
    # path - the url for a DELETE request
    # options - additional options for the DELETE request
    # block - called after the DELETE request is complete
    #
    # Raises Google::AuthenticationRequiredError if the token is no longer valid
    #
    # Returns the response
    def http_delete(path, options={}, &block)
      apply_api_key options # apply the API key if it is not there
      apply_auth_header options # apply the authorization header if it is not there

      response = self.class.delete path, options, &block
      raise AuthenticationRequiredError.new if response.code == 401
      response
    end

    protected
    # Protected: Adds the api key value to the query options
    #
    # Returns nothing
    def apply_api_key(options)
      options.merge! :query => {} unless options.has_key? :query
      options[:query].merge!({ :key => Google.configuration.api_key })
    end

    # Protected: Adds the authorization token to the header
    #
    # Returns nothing
    def apply_auth_header(options)
      apply_header options, "Authorization", "Bearer #{@token}"
    end

    # Protected: Adds a default of application/json to the Content-Type unless
    # one is already specified.
    #
    # Returns nothing
    def apply_content_type_header(options)
      if !options.has_key?(:headers) || !options[:headers].has_key?("Content-Type")
        apply_header options, "Content-Type", "application/json"
      end
    end

    # Protected: Applies the Content-Length of the body
    #
    # Returns nothing
    def apply_content_length_header(options)
      options[:body].nil? ? length = 0 : options[:body].length
      apply_header options, "Content-Length", length.to_s
    end

    # Protected: Applies the specified key and value combination to the header
    #
    # Returns nothing
    def apply_header(options, key, value)
      options.merge! :headers => {} unless options.has_key? :headers
      options[:headers].merge!({ key => value })
    end
  end
end
