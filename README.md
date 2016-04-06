# RailsRestVote

Rails Rest Vote is a Ruby Gem which can add voting feature to any model of your rails application and exposes its RESTful APIs.

If you are using any frontend framework like angular2 in your application it is really helpful.

>**DISCLAIMER**
>
>Host application user managment model name should be `user`, It is recommended to use [devise gem](https://github.com/plataformatec/devise) for authentication purpose.

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

Add below line to the model you want to vote or like on

    has_many :votes, :as => :votable

It can be used in two different ways.

1. Use as two buttons one for upvote and other for downvote as in _stackoverflow_.

    ##### APIs

    > /api/votes/up
    
    Api is used for upvote on model. user must be signed in for upvoting.
    ```
    method: POST 
body: {"votable_id":"1","votable_type":"Service"}
content-type: application/json
response: {"status":200,"message":"upvoted successfully."}
    ```
    
    > /api/votes/down
    
    Api is used for downvote on model. user must be signed in for downvoting.
    ```
    method: POST 
body: {"votable_id":"1","votable_type":"Service"}
content-type: application/json
response: {"status":200,"message":"downvoted successfully."}
    ```
     > /api/votes/user?user_id=1
    
    Api returns upvote and downvote count done by a particular user.
    ```
    method: GET 
content-type: application/json
response: {"status":200,"upcount":1,"upvotes":[{"id":1,...}], "downcount":1,"downvotes":[{"id":3,...}]}
    ```
      > /api/votes/model?votable_id=1&votable_type=Service
    
    Api returns upvote and downvote count done on a particular model.
    ```
    method: GET 
content-type: application/json
response: {"status":200,"upcount":1,"upvotes":[{"id":1,...}], "downcount":1,"downvotes":[{"id":3,...}]}
    ```

2. Use as one button used for like/unlike just like _facebook_.

    ##### APIs

    > /api/likes
    
    Api is used for like. user must be signed in for liking.
    ```
    method: POST 
body: {"votable_id":"1","votable_type":"Service"}
content-type: application/json
response: {"status":200,"message":"liked successfully."}
    ```
    > /api/likes/user?user_id=1
    
    Api returns like count done by a particular user.
    ```
    method: GET 
content-type: application/json
response: {"status":200,"likecount":1,"likes":[{"id":1,...}]}
    ```
    > /api/likes/model?votable_id=1&votable_type=Service
    
    Api returns like count done on a particular model.
    ```
    method: GET 
content-type: application/json
response: {"status":200,"likecount":1,"likes":[{"id":1,...}]}
    ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tixdo/rails_rest_vote. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
