# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require

# require 'sinatra/json'
require 'net/http'

require 'icalendar'
require 'open-uri'

configure do
  set :protection, except: [:frame_options]
end

require 'active_support/all'

ICALENDAR_URL = ENV['ICALENDAR_URL']

def handle_events(params)
  headers 'Access-Control-Allow-Origin' => '*'
  feed =
    URI
    .parse(ICALENDAR_URL.gsub(/PLACEHOLDER/, params['qualifier']))
    .read

  events = Icalendar::Event.parse(feed)

  @results = events.map do |e|
    tmp_tz = e.dtstart.ical_params['tzid']
    timezone = tmp_tz.is_a?(Array) ? tmp_tz.first : tmp_tz

    Time.use_zone(timezone) do
      start_time = Time.parse(e.dtstart.to_s)
      end_time = Time.parse(e.dtend.to_s)
      {
        name: e.summary,
        start_time: start_time,
        end_time: end_time
      }
    end
  end

  if params['filter']
    @results.select! { |res| res[:name] =~ /#{params['filter']}/i }
  end

  @show_from_to = true if params['show_from_to']

  # The limit is one greater than the required limit, because of the
  # header row. The limit is enforced only through CSS.
  @limit = params['limit'] ? params['limit'].to_i + 1 : 26

  if params['format'] != 'json'
    erb :calendar
  else
    json @results
  end
end

# This is a legacy endpoint from back when this microservice was
# primary for showing events from meetup.com groups
get '/meetup/:qualifier' do
  handle_events(params)
end

get '/calendar/:qualifier' do
  handle_events(params)
end

get '/' do
  'Please visit /calendar/YourQualifier'
end
