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

get '/meetup/:meetup_group_url' do
  headers 'Access-Control-Allow-Origin' => '*'
  feed =
    URI
    .parse("https://www.meetup.com/#{params['meetup_group_url']}/events/ical/")
    .read

  events = Icalendar::Event.parse(feed)

  @results = events.map do |e|
    timezone = e.dtstart.ical_params['tzid'].first

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

get '/' do
  'Please visit /meetup/YourMeetupGroupURL'
end
