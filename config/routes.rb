Rails.application.routes.draw do
  namespace :rails_rest_vote do
    namespace :api do
      post 'up' => 'votes#up' #API for voting up
      post 'down' => 'votes#down' #API for voting down
      post 'like' => 'votes#like' #API for like unlike feature
      get 'vote_count/user' => 'votes#user_vote_count' #API for vote count done by a particular user
      get 'vote_count/model' => 'votes#model_vote_count' #API for vote count done on particular model
      get 'like_count/user' => 'votes#user_like_count' #API for like count done by a particular user
      get 'like_count/model' => 'votes#model_like_count' #API for like count done on particular model
    end
  end
end
