require 'httparty'
require 'json'
require 'open-uri'

require 'gcal_unit/client'
require 'gcal_unit/calendar_list'
require 'gcal_unit/calendar'
require 'gcal_unit/event'
require 'gcal_unit/errors'
require 'gcal_unit/authorization'
require 'gcal_unit/configuration'

# Public: Contains all the methods for wrapping the Google API.
module Google
  # Public: Holds the configuration for calling methods within
  # the Google API.
  #
  # Returns a hash used for configuring the calls.
  #   :api_key - Identifies the application requesting the call.
  #              Sent with all the API calls.
  #   :client_id - The OAuth client id that is used to generate
  #                access tokens.
  #   :client_secret - The OAuth client secret that is used to
  #                    generate access tokens.
  #   :refresh_token - A token that is used to retrieve an access
  #                    token when the original token expires.
  def self.configuration
    @configuration ||= Google::Configuration.new
  end

  # Public: Allows configuration for the Google API.
  #
  # Yields the configuration for the Google API.
  def self.configure
    yield configuration if block_given?
  end

  VERSION = "1.0.1"
end
