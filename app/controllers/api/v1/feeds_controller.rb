module Api
  module V1
    class FeedsController < ApplicationController
      before_action :set_feed, only: [:show, :update]

      def index
        feeds = Feed.all
        render json: feeds
      end

      def show
        render json: @feed
      end

      def create
        feed = Feed.new(feed_params)
        if feed.save
          render json: feed, status: :created
        else
          render json: feed.errors, status: :unprocessable_entity
        end
      end

	  def update
	    if @feed.update(feed_params)
	      render json: @feed, status: :ok
	    else
	      render json: { errors: @feed.errors.full_messages }, status: :unprocessable_entity
	    end
	  end

      private

      def feed_params
        params.require(:feed).permit(:name, :protein, :fat, :fiber, :vitamins, :minerals)
      end

      def set_feed
	    @feed = Feed.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	    render json: { error: "Feed not found" }, status: :not_found
	  end
    end
  end
end
