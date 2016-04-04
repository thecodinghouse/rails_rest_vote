Rails.application.routes.draw do
  namespace :rails_rest_vote do
    namespace :api do
      resources :votes, only: [:index, :create, :update]
    end
  end
end
