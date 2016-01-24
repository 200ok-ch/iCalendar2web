# Rationale

Meetup is great to organise your local meetup. Meetup also has great sharing
and API options. They do support embeding the meetup group together with the
next meetup. However, there is no out-of-the-box support to embed your
schedule to another website.

This is a Ruby Sinatra project that solves this issue by accessing the
Meetup API and simply rendering an HTML table. Hosting can be done on
Heroku to get you started. There is also a hosted SaaS version (see below).

## Demo

As a tutor of the [Insopor Zen Academy](http://insopor-zen-academy.com), I run
the Sinopa Zen House. There is a daily meditation schedule that regularly
updated on Meetup. However, I want that schedule also to be seen on our
website. You can see this as a demo
[here](insopor-zen-academy.com/zen-meditation-schedule/).

## Use as a Service

meetup\_cal is generic in that it can render any public Meetup schedule. Instead
of installing meetup\_cal yourself, you can use this hosted version:

[http://meetup-calendar.herokuapp.com/meetup/YourMeetupGroupURL](http://meetup-calendar.herokuapp.com/meetup/YourMeetupGroupURL)

With YourMeetupGroupURL being the Meetup Group URL, eg nystartrek.

If you want to use meetup_\cal as a Service, please note that it will display
times for the Europe/Berlin timezone.

### iFrame

If you want to embed it to your own website, use an iframe - similar to
Youtube or Voice Republic:

```html
<iframe width="800px" height="800px"
    src="http://meetup-calendar.herokuapp.com/meetup/Herrliberg-Sinopa-Zen-House-Meditation"
    frameborder="0">
</iframe>
```
### Load via Ajax

You can also load the html via Ajax into your page. For example if you
want to show a loading spinner upfront. The required access-control
headers are set on this service, so no worries about CORS.

```javascript
$.get("http://meetup-calendar.herokuapp.com/meetup/MyMeetupGroup", function(data) {
  $("#my-schedule").html(data);
});
```
# Parameters

meetup\_cal takes the following parameters:

* 'filter': takes a RegExp to filter the name of the meetup
* 'show\_from\_to': when set, this changes the default look from |date|time| to |date from|date to|
* 'limit': set a limit of how often a specific meetup shall be repeated in the table, the default is 25

# Deployment

## Heroku

Please refer to the documentation of Heroku to install

https://devcenter.heroku.com/articles/rack

To access your meetup calendar via API you will require your API
key. You can find it here:
[https://secure.meetup.com/meetup_api/key/](https://secure.meetup.com/meetup_api/key/)

And then configure Heroku to know about it like this:

`heroku config:set MEETUP_API_KEY=[your-api-key]`

# Running

Export your `MEETUP_API_KEY` and run `rackup config.ru`.
