# RailsRestVote
[![Gem Version](https://badge.fury.io/rb/rails_rest_vote.svg)](https://badge.fury.io/rb/rails_rest_vote)

Rails Rest Vote is a Ruby Gem which can add voting feature to any model of your rails application and exposes its RESTful APIs.

If you are using any frontend framework like angular2 in your application it is really helpful.



>Your rails application user managment model name should be `user`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_rest_vote'
```
And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails_rest_vote

#### Database Migrations

Run below command in your project folder from terminal.

    $ rails g rails_rest_vote user

It will do three things for you.

- Create a migration file of Vote table in db/migrate/ folder.
- Insert association in user model i.e has_many :votes
- Create vote model i.e app/models/vote.rb

After that migrate database by using.

    $ rake db:migrate

Now you are ready to go.

## Usage

Add below line to the model you want add upvote/downvote or like/unlike functionality

    has_many :votes, :as => :votable

It can be used in two different ways.

1. Use as upvote/downvote just like _stackoverflow_.

    ##### APIs

    > /api/votes/up

    API is used for upvote on model.
    ```
    method: POST
body: {"votable_id":"1","votable_type":"Service","user_id":"1"}
content-type: application/json
response: {"status":200,"message":"upvoted successfully."}
    ```

    > /api/votes/down

    API is used for downvote on model.
    ```
    method: POST
body: {"votable_id":"1","votable_type":"Service","user_id":"1"}
content-type: application/json
response: {"status":200,"message":"downvoted successfully."}
    ```
     > /api/votes/user?user_id=1

    API returns upvote and downvote count done by a particular user.
    ```
    method: GET
content-type: application/json
response: {"status":200,"upcount":1,"upvotes":[{"id":1,...}], "downcount":1,"downvotes":[{"id":3,...}]}
    ```
      > /api/votes/model?votable_id=1&votable_type=Service

    API returns upvote and downvote count done on a particular model.
    ```
    method: GET
content-type: application/json
response: {"status":200,"upcount":1,"upvotes":[{"id":1,...}], "downcount":1,"downvotes":[{"id":3,...}]}
    ```

2. Use as like/unlike just like _facebook_.

    ##### APIs

    > /api/likes

    Same API is used for like and unlike. for first time if you hit this api it will work as `like` and If you send same parameters second time it will remove the record from vote table i.e `unlike`
    ```
    method: POST
body: {"votable_id":"1","votable_type":"Service","user_id":"1"}
content-type: application/json
response: {"status":200,"message":"liked successfully."}
    ```
    > /api/likes/user?user_id=1

    API returns like count done by a particular user.
    ```
    method: GET
content-type: application/json
response: {"status":200,"likecount":1,"likes":[{"id":1,...}]}
    ```
    > /api/likes/model?votable_id=1&votable_type=Service

    API returns like count done on a particular model.
    ```
    method: GET
content-type: application/json
response: {"status":200,"likecount":1,"likes":[{"id":1,...}]}
    ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tixdo/rails_rest_vote. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
