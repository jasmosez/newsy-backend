# README

## OVERVIEW
Newsy is a tool to browse political journalists, their articles and social media feeds and rate their journalistic integrity

This backend is an API that pulls data from newsapi and the NYTimes API. You will need your own API keys for both.

The frontend can be found here: https://github.com/jasmosez/newsy-frontend.

## Ruby/Rails versions
Uses Ruby 2.6.1 and Rails 6.0.2.2

## Configuration
create an .env file in the root directory defining `OS_KEY` as your open states API key

## Database creation
### Migrate the database
rails db:migrate

### Seed the database
rails db:seed

Note that /db/seeds.rb contains, but does not use some methods for parsing collections of legislator twitter handles and exporting user data as csv files. To date this is all being done in an ad hoc fashion.

## How to run the test suite
There is not test coverage at this time

## Current Deployment(s)
The backend is currently deployed at https://ilobby-backend.herokuapp.com
The frontend is currently deployed at https://ilobby.thisjames.com

# Let me know what you think!
Feel free to browse the [iLobby project Trello board](https://trello.com/b/9C6jGF7k/ilobby) as well

