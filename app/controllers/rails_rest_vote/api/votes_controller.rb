require "json"

module RailsRestVote
  class Api::VotesController < ApplicationController
    #No record found exception handled
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    #This would turn off the CSRF check for json api posts/puts
    skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

    #check current_user existance before voting actions
    before_action :current_user?, :only=>[:up, :down, :exists]

    #check user already voted or not
    before_action :exists?, :only=>[:up, :down, :like]

    #intialize user
    before_action :initialize_user, :only=>[:user_vote_count, :user_like_count]

    #intialize votable object
    before_action :initialize_votable_object, :only=>[:model_vote_count, :model_like_count]


    #up vote is created form current user reference.
    #vote value should be true.
    #return success json i.e {"status":200,"message":"upvoted successfully."}
    #
    def up
      upvote = current_user.votes.new(vote_params)
      upvote.vote = true
      send_post_response(upvote)
    end

    #down vote is created form current user reference.
    #vote value should be false.
    #return success json i.e {"status":200,"message":"downvoted successfully."}
    #
    def down
      downvote = current_user.votes.new(vote_params)
      downvote.vote = false
      send_post_response(downvote)
    end

    #return vote up and down count of particular user.
    #{"status":200,"upcount":1,"upvotes":[{"id":1,...}], "downcount":2,"downvotes":[{"id":3,...},{"id":2,...}]}
    #
    def user_vote_count
      upvotes = @user.votes.where(:vote => true)
      downvotes = @user.votes.where(:vote => false)
      send_get_response(upvotes,downvotes)
    end

    #return vote up and down count on particular model.
    #{"status":200,"upcount":1,"upvotes":[{"id":1,...}], "downcount":2,"downvotes":[{"id":3,...},{"id":2,...}]}
    #
    def model_vote_count
      upvotes = @votable.votes.where(:vote => true)
      downvotes = @votable.votes.where(:vote => false)
      send_get_response(upvotes,downvotes)
    end

    #like and unlike feature handled from this method
    #if record already present it just delete.
    #response { status: :ok, message: "unliked successfully." })
    #else response { status: :ok, message: "liked successfully." })
    #
    def like
      like = current_user.votes.new(vote_params)
      send_post_response(like)
    end

    #return like count of particular user.
    #{"status":200,"likecount":1,"likes":[{"id":1,...}]}
    #
    def user_like_count
      likes = @user.votes
      send_like_response(likes)
    end

    #return like count on particular model.
    #{"status":200,"likecount":1,"likes":[{"id":1,...}]}
    #
    def model_like_count
      likes = @votable.votes
      send_like_response(likes)
    end

    private

    #check existance of record before creation
    def exists?
      params[:vote][:votable_type] = params[:vote][:votable_type].capitalize
      vote = params[:action] == "like" ? nil :  params[:action] == "up" ? true : false
      uservotes = current_user.votes.where("votable_id = ? AND votable_type = ? AND vote = ?",params[:vote][:votable_id],params[:vote][:votable_type],vote)
      return uservotes.size > 0 ? voted(uservotes) : true
    end

    #intialize user object from params[:user_id]
    def initialize_user
      @user = User.find(params[:user_id])
    end

    #intialize votable object from params[:votable_id]
    #constantize tries to find a declared constant with the name specified in the string
    #
    def initialize_votable_object
      @votable = params[:votable_type].to_s.capitalize.constantize.find(params[:votable_id])
    end

    def voted(uservotes)
      if params[:action] == "like"
        uservotes.first.delete
        render(json: { status: :ok, message: "unliked successfully." })
      else
        render(json: { status: :ok, message: "you already #{params[:action]}voted." })
      end
    end

    def send_get_response(upvotes,downvotes)
      render(json: { status: :ok, upcount: upvotes.size ,upvotes:JSON.parse(upvotes.to_json), downcount: downvotes.size,downvotes: JSON.parse(downvotes.to_json) })
    end

    def send_post_response(vote)
      if vote.save
        if params[:action] == "like"
          render(json: { status: :ok, message: "liked successfully." })
        else
          render(json: { status: :ok, message: "#{params[:action]}voted successfully." })
        end
      else
        render(json: { status: :unprocessable_entity, message: vote.errors })
      end
    end

    def send_like_response(likes)
      render(json: { status: :ok, likecount: likes.size ,likes:JSON.parse(likes.to_json)})
    end

    def current_user?
      return !current_user.blank? ? true : unauthenticated!
    end

    def unauthenticated!
      render( json: {status: :unauthorized, errors:"unauthorized access"})
    end

    def not_found(e)
      render(json: {status: :not_found, errors: e.message})
    end

    def vote_params
      params[:vote].permit(:votable_id, :votable_type)
    end

  end
end
