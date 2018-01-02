Rails.application.routes.draw do
    post 'api/votes/up' => 'rails_rest_vote/api/votes#up' #API for voting up
    post 'api/votes/down' => 'rails_rest_vote/api/votes#down' #API for voting down
    post 'api/likes' => 'rails_rest_vote/api/votes#like' #API for like unlike feature
    get 'api/votes/user' => 'rails_rest_vote/api/votes#user_vote_count' #API for vote count done by a particular user
    get 'api/votes/model' => 'rails_rest_vote/api/votes#model_vote_count' #API for vote count done on particular model
    get 'api/likes/user' => 'rails_rest_vote/api/votes#user_like_count' #API for like count done by a particular user
    get 'api/likes/model' => 'rails_rest_vote/api/votes#model_like_count' #API for like count done on particular model
end
