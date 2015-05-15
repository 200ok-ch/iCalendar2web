# Rationale

Meetup is great to organise your local meetup. Meetup also has great sharing
and API options. They do support embeding the meetup group together with the
next meetup. However, there is no out-of-the-box support to embed your
schedule to another website.

This is a Sinatra project that solves this issue by accessing the Meetup API
and simply rendering an HTML table. Hosting can be done on Heroku to get you
started. The table is explicitly not styled so you can do that from your
consuming application.

## Demo

As a tutor of the [Insopor Zen Academy](http://insopor-zen-academy.com), I run
the Sinopa Zen House. There is a daily meditation schedule that regularly
updated on Meetup. However, I want that schedule also to be seen on our
website. You can see this as a demo
[here](http://insopor-zen-academy.com/zen-houses/sinopa-zen-house-menu/schedule)


# Deployment

## Heroku

Please refer to the documentation of Heroku to install

https://devcenter.heroku.com/articles/rack

To access your meetup calendar via API you will require your API key. You can
find it here:
[https://secure.meetup.com/meetup_api/key/](https://secure.meetup.com/meetup_api/key/)

And then configure Heroku to know about it like this:

`heroku config:set MEETUP_API_KEY=[your-api-key]`
