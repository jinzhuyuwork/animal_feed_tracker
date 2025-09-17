module Api
  module V1
    class FormulationsController < ApplicationController
      before_action :set_formulation, only: [:show, :update]
      
      def index
        formulations = Formulation.all
        render json: formulations
      end

      def show
        render json: @formulation
      end

      def create
        formulation = Formulation.new(formulation_params)
        if formulation.save
          render json: formulation, status: :created
        else
          render json: formulation.errors, status: :unprocessable_entity
        end
      end

	  def update
	    if @formulation.update(formulation_params)
	      render json: @formulation, status: :ok
	    else
	      render json: { errors: @formulation.errors.full_messages }, status: :unprocessable_entity
	    end
	  end

      private

      def formulation_params
        params.require(:formulation).permit(:annimal_id, :feed_id, :quantity)
      end

      def set_formulation
	    @formulation = Formulation.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	    render json: { error: "Formulation not found" }, status: :not_found
	  end
    end
  end
end

