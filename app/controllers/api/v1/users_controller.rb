module Api
  module V1
    class UsersController < ApplicationController
      # GET /api/v1/users/me
      def me
        render json: current_user.as_json(only: [:id, :email, :created_at])
      end
    end
  end
end