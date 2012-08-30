G-G-G-GCal-Unit!
==========================
***

![GCal Unit](https://s3.amazonaws.com/github-gcal-unit/gcal-unit.png)

## GANGSTA SH*T

GCal-Unit is a bullet proof vest for the Google Calendar API. It will pimp the hell out of your applications. This rapper is used only for Google Calendar API calls and not any other Google APIs (except for making those Google tokens fresh).

## LOADING THE CLIP

To start caping fools, you have to install this sh*t.

```
gem install gcal-unit
```

This will also load [httparty](http://github.com/jnunemaker/httparty) in your pimp cup.

## CANDY SHOP

I'll break it down for you, baby it's simple.

```ruby
#token is the user's Google API access token, yo

# Get a list of a your Google calendars
list = Google::CalendarList.new(token).list

# Get the user's primary Google calendar
primary = Google::Calendar.new(token).get("primary")

# Get a list of events from a calendar
events = Google::Event.new(token).nested_for('primary').list

# Get a single event from a calendar
event = Google::Event.new(token).nested_for('primary').get(event_id)

# Insert an event for a calendar
event = Google::Event.new(token).nested_for('primary').insert({
  end: { date: { '1975-07-06' } },
  start: { date: { '1975-07-06' } },
  description: { string: { 'I was born.' } }
})

# Update an event for a calendar
event = Google::Event.new(token).nested_for('primary').update(event_id, {
  end: { date: { 'I was born with a pimp cup.' } }
})

# Delete an event
Google::Event.new(token).nested_for('primary').delete(event_id)

# Use the quick add feature
event = Google::Event.new(token).nested_for('primary').quick_add('got shot 9 times yesterday at 2am')
```

The base URI for all of the API operations is: [http://www.googleapis.com/calendar/v3](http://www.googleapis.com/calendar/v3)

If you have an interest in reading other things than c-notes, you can find the Google API Calendar documentation at [http://developers.google.com/google-apps/calendar/v3/reference](http://developers.google.com/google-apps/calendar/v3/reference)

Each Google Calendar API model requires an API token. This token (as well as a refresh token) can be retrieved by using OAuth (we recommend [OmniAuth](https://github.com/intridea/omniauth)). If the token expires, you can use the authentication method in this library and your refresh token to refresh the API token for future calls.

```ruby
# refresh_token is your Google API refresh token for your registered application

client = Google::Authorization.new(refresh_token)
token = client.refresh()['access_token']  # use this token for all the api calls
```

## WANKSTA

Configure the Google API wrapper with the sensitive data needed to make Google API calls.

```ruby
Google.configure do |config|
  config.api_key = ENV['GOOGLE_API_KEY']
  config.client_id = ENV['GOOGLE_CLIENT_ID']
  config.client_secret = ENV['GOOGLE_CLIENT_SECRET']
  # You can also set the refresh token here as well for later retreival but
  # refresh tokens are not app specific but user specific, yo
end
```

## KNOW YOUR HOOD

When contributing use [dotenv](https://github.com/bkeepers/dotenv) to hold your sensitive data. The gem contains an example `.env` file. The `.env` file is in the .gitignore so your sensitive information will not be exposed.

## IN DA CLUB

To run the tests, there is some configuration that probably needs to occur. 
The test suite uses VCR to make the initial calls to Google and then records the response.
In order to make that initial call to Google work, we included a simple Sinatra application that you can
run to record the correct refresh token for authentication.

Here are the steps to make yo sh*t tight.

1. visit https://developers.google.com/google-apps/calendar/
1. sign in (upper right) with a Google account you want to use for testing
1. visit https://code.google.com/apis/console
1. create a project
1. turn on calendar api
1. visit api access
1. create an oauth 2.0 client id
1. choose web application
1. choose http://localhost for hostname
1. click on create client id
1. edit settings and change redirect uri to http://localhost:3000/auth/google_oauth2/callback
1. cp example.env .env
1. change the GOOGLE_CLIENT_ID key to your client id in the .env file
1. change the GOOGLE_CLIENT_SECRET key to your client secret in the .env file
1. change the GOOGLE_API_KEY key to your API key in the .env file
1. change the GOOGLE_TEST_USER key to who you are going to sign in as below when you run the Sinatra app
1. bundle install --gemfile=bootstrapper/Gemfile
1. rackup bootstrapper/config.ru -p 3000
1. open your browser to http://localhost:3000 and authenticate with Google
1. the GOOGLE_REFRESH_TOKEN will be added to your .env file
1. add the user email that you signed in with to the .env file for the GOOGLE_TEST_USER key

(Welcome to OAuth. So many steps, my grill is tarnishing)

## GET RICH OR DIE TRYIN'

To contribute, just take a hit and do the rest.

* Fork the project
* Create a test that indicates your behavior
  * If you are using an http call, wrap your call with VCR
* Code your feature or fix the bug
* Commit (do not bump the version)
* Send pull request

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
