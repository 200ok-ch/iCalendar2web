# Deployment

## Heroku

Please refer to the documentation of Heroku to install

https://devcenter.heroku.com/articles/rack

To access your meetup calendar via API you will require your API key. You can
find it here:
[https://secure.meetup.com/meetup_api/key/](https://secure.meetup.com/meetup_api/key/)

And then configure Heroku to know about it like this:

`heroku config:set MEETUP_API_KEY=[your-api-key]`
