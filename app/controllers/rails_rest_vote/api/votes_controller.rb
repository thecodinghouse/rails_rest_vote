require "json"

module RailsRestVote
  class Api::VotesController < ApplicationController

    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!, :only=>[:up ,:down,:exists]
    before_action :exists, :only=>[:up ,:down]

    def up
      upvote = current_user.votes.new(vote_params)
      upvote.vote = true
      if upvote.save
        render(json: { status: 200, message: "upvoted successfully." })
      else
        render(json: { status: :unprocessable_entity, message: upvote.errors })
      end
    end

    def down
      downvote = current_user.votes.new(vote_params)
      downvote.vote = false
      if downvote.save
        render(json: { status: 200, message: "downvoted successfully." })
      else
        render(json: { status: :unprocessable_entity, message: downvote.errors })
      end
    end

    def user_vote_count
      user = User.find(params[:user_id])
      upvotes = user.votes.where(:vote => true)
      downvotes = user.votes.where(:vote => false)
      render(json: { status: 200, upcount: upvotes.size ,upvotes:JSON.parse(upvotes.to_json), downcount: downvotes.size,downvotes: JSON.parse(downvotes.to_json) })
    end

    def model_vote_count
      upvotes = Vote.where("votable_id = ? AND votable_type = ? AND vote = true",params[:votable_id],params[:votable_type].capitalize)
      downvotes = Vote.where("votable_id = ? AND votable_type = ? AND vote = false",params[:votable_id],params[:votable_type].capitalize)
      render(json: { status: 200, upcount: upvotes.size ,upvotes:JSON.parse(upvotes.to_json), downcount: downvotes.size,downvotes: JSON.parse(downvotes.to_json) })
    end

    private

    def exists
      params[:vote][:votable_type] = params[:vote][:votable_type].capitalize
      vote = params[:action] == "up" ? true : false
      uservotes = current_user.votes.where("votable_id = ? AND votable_type = ? AND vote = ?",params[:vote][:votable_id],params[:vote][:votable_type],vote)
      return uservotes.size > 0 ? voted : true
    end

    def authenticate_user!
      return !current_user.blank? ? true : unauthenticated!
    end

    def unauthenticated!
      render( json: {errors:"Unauthorized Access"})
    end

    def voted
      render(json: { status: 200, message: "you already voted." })
    end

    def vote_params
      params[:vote].permit(:votable_id,:votable_type)
    end
  end
end
