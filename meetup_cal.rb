require 'rubygems'
require 'bundler'
Bundler.require

require 'net/http'

configure do
  set :protection, except: [:frame_options]
end

MEETUP_API_KEY = ENV['MEETUP_API_KEY']
get '/sinopa' do
  url = "http://api.meetup.com/2/events?offset=0&format=json&limited_events=False&group_urlname=Herrliberg-Sinopa-Zen-House-Meditation&photo-host=public&page=20&fields=&order=time&desc=false&status=upcoming&sign=true"
  url += "&key=#{MEETUP_API_KEY}"

  res = Net::HTTP.get(URI(url))

  parsed = JSON.parse(res)
  @results = parsed['results']
  haml :calendar
end
