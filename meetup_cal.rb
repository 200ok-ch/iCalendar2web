# frozen_string_literal: true

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
  url = 'http://api.meetup.com/2/events?offset=0&format=json&limited_events=False' \
        "&group_urlname=#{params['meetup_group_url']}" \
        '&photo-host=public&page=200&fields=&order=time&desc=false&status=upcoming&sign=true' \
        "&key=#{MEETUP_API_KEY}"

  res = Net::HTTP.get(URI(url))

  parsed = JSON.parse(res)
  @results = parsed['results']

  if params['filter']
    @results.select! { |res| res['name'] =~ /#{params['filter']}/i }
  end

  @show_from_to = true if params['show_from_to']

  # The limit is one greater than the required limit, because of the
  # header row. The limit is enforced only through CSS.
  @limit = params['limit'] ? params['limit'].to_i + 1 : 26

  haml :calendar
end

get '/' do
  'Please visit /meetup/YourMeetupGroupURL'
end
