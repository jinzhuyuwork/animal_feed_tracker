module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def me
        render json: current_user.as_json(only: [ :id, :email, :admin, :created_at ])
      end
    end
  end
end
