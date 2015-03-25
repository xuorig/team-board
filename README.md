# TeamBoard ![Build Status](https://travis-ci.org/xuorig/team-board.svg?branch=master)
## Mini Project Management Tool And Shareable Web Whiteboard

### Built With

[Ruby on Rails](http://rubyonrails.org/) — Back end API is a Rails app. It responds to requests RESTfully in JSON.

[AngularJS](https://angularjs.org/) — The front end is an AngularJS app that communicates with the Rails API.

[PostgreSQL](http://www.postgresql.org/) — Our main database is in Postgres.

[Puma](https://github.com/puma/puma) - We use puma to handle concurrency

And a lot of Ruby Gems at [/master/Gemfile](https://github.com/xuorig/team-board/blob/master/Gemfile).

### How to Run

1. Clone Repo
2. Configure google dev console + sendgrid env variables
2. bundle install
3. bundle exec rake bower:install
4. bundle exec puma -C config/puma.rb
