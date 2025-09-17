module Api
  module V1
    class FeedsController < ApplicationController
      def index
        feeds = Feed.all
        render json: feeds
      end

      def show
        feed = Feed.find(params[:id])
        render json: feed, include: :annimals
      end

      def create
        feed = Feed.new(feed_params)
        if feed.save
          render json: feed, status: :created
        else
          render json: feed.errors, status: :unprocessable_entity
        end
      end

      private

      def feed_params
        params.require(:feed).permit(:name, :protein, :fat, :fiber, :vitamins, :minerals)
      end
    end
  end
end
