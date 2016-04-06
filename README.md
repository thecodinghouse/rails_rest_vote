# RailsRestVote

Rails Rest Vote is a Ruby Gem which can add voting feature to any model of your rails application and exposes its restful apis.

If you are using any frontend framework like angular2 in your website and backend in rails it is really helpful.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_rest_vote'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails_rest_vote

## Database Migrations

Run below command in your project folder from terminal.

    $ rails g rails_rest_vote

It will do three things for you.

1. Create a migration file of Vote table in db/migrate/ folder.
2. Insert association in user model i.e has_many :votes
3. Create vote model i.e app/models/vote.rb

After that migrate database by using.

    $ rake db:migrate

Now you are ready to go.

## Usage

It can be used in two different ways.
1. You have two buttons on view one for upvote and other for downvote as in stackoverflow.
2. One button used for like/unlike just like facebook.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tixdo/rails_rest_vote. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
