module RailsRestVote
  class Api::VotesController < ApplicationController
    def index
      #votes = Vote.all
      render(json: { status: 200, message: "Index" })
    end

    def create
      render(json: { status: 200, message: "Create" })
    end

    def update
      render(json: { status: 200, message: "Update" })
    end
  end
end
