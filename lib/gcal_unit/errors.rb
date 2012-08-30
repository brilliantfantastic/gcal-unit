module Google
  # Public: Error that specifies the specified token is no longer valid.
  class AuthenticationRequiredError < SecurityError; end

  # Public: Error that specifies a calendar id was not provided.
  class CalendarRequiredError < RuntimeError; end
end
