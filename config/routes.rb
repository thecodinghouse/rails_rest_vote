Rails.application.routes.draw do
  namespace :rails_rest_vote do
    namespace :api do
      post 'up' => 'votes#up'
      post 'down' => 'votes#down'
      get 'vote_count/user' => 'votes#user_vote_count'
      get 'vote_count/model' => 'votes#model_vote_count'
    end
  end
end
