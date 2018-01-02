# RailsRestVote
[![Gem Version](https://badge.fury.io/rb/rails_rest_vote.svg)](https://badge.fury.io/rb/rails_rest_vote)

Rails Rest Vote is a Ruby Gem which adds voting feature to any model of your rails application and exposes its RESTful APIs.

If you are using any frontend client like angular2 in your web app and also for mobile apps, it is really helpful.

## Prerequisites

#### Enabling CORS

If you’re building a public API you’ll probably want to enable Cross-Origin Resource Sharing (CORS), in order to make cross-origin AJAX requests possible.

This is made very simple by the rack-cors gem. Just stick it in your Gemfile like so:
```
gem 'rack-cors'
```
And put something like the code below in config/application.rb of your Rails application. For example, this will allow GET, POST or OPTIONS requests from any origin on any resource.
```
module YourApp
  class Application < Rails::Application

    # ...

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

  end
end
```
>For more detailed configuration options please see the gem [documentation](https://github.com/cyu/rack-cors)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_rest_vote'
```
And then execute:

    $ bundle install

Run the following command in your project folder:

    $ rails g rails_rest_vote MODEL

In the above command you will need to replace `MODEL` with the class name used for the application’s users (it’s frequently `User` but could also be `Admin`)

It will do 3 things for you:

- Create a migration file of Vote table in db/migrate/ folder.
- Insert association in user model i.e has_many :votes
- Create vote model i.e app/models/vote.rb

After that migrate database by using.

    $ rake db:migrate

Now you are good to go.

## Usage

Add below line to the model for which you want to record `upvote/downvote` or `like/unlike` functionality:

    has_many :votes, :as => :votable

It can be used in 2 ways, I am using `Post` model in below examples:

1. Use as `upvote/downvote` ( _stackoverflow_):

    ##### APIs

    > /api/votes/up

    API is used for upvote on model.
    ```
    method: POST
    body: {"votable_id":"1","votable_type":"Post","user_id":"1"}
    content-type: application/json
    response: {"status":200,"message":"upvoted successfully."}
    ```

    > /api/votes/down

    API is used for downvote on model.
    ```
    method: POST
    body: {"votable_id":"1","votable_type":"Post","user_id":"1"}
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
      > /api/votes/model?votable_id=1&votable_type=Post

    API returns upvote and downvote count done on a particular model.
    ```
    method: GET
    content-type: application/json
    response: {"status":200,"upcount":1,"upvotes":[{"id":1,...}], "downcount":1,"downvotes":[{"id":3,...}]}
    ```

2. Use as `like/unlike` ( _facebook_):

    ##### APIs

    > /api/likes

    Same API is used for like and unlike functionality.For the first time if you hit this API , it will work as `like` and if you send same parameters second time it will remove record from the vote table i.e `unlike`
    ```
    method: POST
    body: {"votable_id":"1","votable_type":"Post","user_id":"1"}
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
    > /api/likes/model?votable_id=1&votable_type=Post

    API returns like count done on a particular model.
    ```
    method: GET
    content-type: application/json
    response: {"status":200,"likecount":1,"likes":[{"id":1,...}]}
    ```
    
>`user_id` inside request body can be `admin_id`, it depends on the application’s users model (it’s frequently `User` but could also be `Admin`)

>Note: Depending on your use case, both features can be used in same application.

## Token-based authentication

If you are using **Token-based authentication** for authorizing requests, You can do in ApplicationController of your app.
```
# app/controllers/application_controller.rb 
class ApplicationController < ActionController::API 
    before_action :authenticate_request 
    attr_reader :current_user 
    
    private 
    def authenticate_request
       # Here you can read headers and check for current user. this example is for `jwt` check below link for more.
       @current_user = AuthorizeApiRequest.call(request.headers).result render json: { error: 'Not Authorized' }, status: 401 unless @current_user 
    end 
end
```
>Read [token-based-authentication-with-ruby-on-rails-5-api](https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api) blog post for integration.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tixdo/rails_rest_vote. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
