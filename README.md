# README

## OVERVIEW
Newsy is a tool to browse political journalists, their articles and social media feeds and rate their journalistic integrity

This backend is an API that pulls data from newsapi and the NYTimes API. You will need your own API keys for both.

The frontend can be found here: https://github.com/jasmosez/newsy-frontend.

## Ruby/Rails versions
Uses Ruby 2.6.1 and Rails 6.0.2.2

## Configuration
create an .env file in the root directory defining these:

* `NYTIMES_API_KEY`
* `NEWSAPI_KEY`


## Database creation
### Migrate the database
rails db:migrate

### Seed the database
rails db:seed

Note that /db/seeds.rb contains, but does not call some methods for populating dummy images where API's do not supply images for articles as well as dummy ratings data. These can be copies and pasted to a rails console for additional ad hoc seeding

## How to run the test suite
There is not test coverage at this time

# Let me know what you think!
Newsy was built in collaboration with shakilabdin

