require 'rubygems'
require 'bundler'
Bundler.require

require 'net/http'

configure do
  set :protection, except: [:frame_options]
end

require 'active_support/all'

MEETUP_API_KEY = ENV['MEETUP_API_KEY']
get '/meetup/:meetup_group_url' do
  headers 'Access-Control-Allow-Origin' => '*'
  url = "http://api.meetup.com/2/events?offset=0&format=json&limited_events=False" +
    "&group_urlname=#{params['meetup_group_url']}" +
    "&photo-host=public&page=20&fields=&order=time&desc=false&status=upcoming&sign=true" +
    "&key=#{MEETUP_API_KEY}"

  res = Net::HTTP.get(URI(url))

  parsed = JSON.parse(res)
  @results = parsed['results']
  haml :calendar
end

get '/' do
  "Please visit /meetup/YourMeetupGroupURL"
end
