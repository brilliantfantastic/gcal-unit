# Sample application taken from github.com/zquestz/omniauth-google-oauth2
# Run with "bundle exec rackup"
# If you'd like to use a specific port user "bundle exec rackup -p $PORT"
# where $PORT is the number you'd like this app to run on.

require 'sinatra'
require 'dotenv'
require 'omniauth'
require 'omniauth-google-oauth2'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
Dotenv.load

class App < Sinatra::Base
  get '/' do
    <<-HTML
    <ul>
      <li><a href='/auth/google_oauth2'>Sign in with Google</a></li>
    </ul>
    HTML
  end


  # Make sure that the request uri for the app you're using to develop this is:
  # http://localhost:$PORT/auth/google_oauth2/callback where $PORT is the number used
  # to start this sinatra app.
  get '/auth/:provider/callback' do
    env = File.join(File.dirname(__FILE__), '../.env')
    token = request.env['omniauth.auth']['credentials']['refresh_token']
    File.open(env, 'a') do |f|
      f.puts "GOOGLE_REFRESH_TOKEN=#{token}"
    end
    content_type 'text/plain'
    "Nice! now your .env has a refresh token: #{token}\n to play with so you can run the tests"
  end

  get '/auth/failure' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue 'No Data'
  end
end

use Rack::Session::Cookie, :secret => ENV['RACK_COOKIE_SECRET']

use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    :scope => ENV['GOOGLE_SCOPE'],
    :access_type => 'offline', # This is a request for a refresh token so you only need to authenticate once
    :approval_prompt => 'force'
  }
end

run App.new
