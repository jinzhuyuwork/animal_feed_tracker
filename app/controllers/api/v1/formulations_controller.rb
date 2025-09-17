module Api
  module V1
    class FormulationsController < ApplicationController
      def index
        formulations = Formulation.all
        render json: formulations
      end

      def show
        formulation = Formulation.find(params[:id])
        render json: formulation
      end

      def create
        formulation = Formulation.new(formulation_params)
        if formulation.save
          render json: formulation, status: :created
        else
          render json: formulation.errors, status: :unprocessable_entity
        end
      end

      private

      def feed_params
        params.require(:formulation).permit(:annimal_id, :feed_id, :quantity)
      end
    end
  end
end

