module Api
  module V1
    class AnimalsController < ApplicationController
      before_action :set_animal, only: [ :show, :update ]

      # Only admins can create/update
      before_action :require_admin!, only: [ :create, :update ]

      def index
        animals = Animal.all
        render json: animals
      end

      def show
        render json: @animal
      end

      def create
        animal = Animal.new(animal_params)
        if animal.save
          render json: animal, status: :created
        else
          render json: animal.errors, status: :unprocessable_entity
        end
      end

      def update
      if @animal.update(animal_params)
        render json: @animal, status: :ok
      else
        render json: { errors: @animal.errors.full_messages }, status: :unprocessable_entity
      end
    end

      # GET /api/v1/animals_with_feeds
      def with_feeds
        animals = Animal.includes(formulations: :feed)

        render json: animals.as_json(
          only: [ :id, :name, :species, :age, :weight ],
          include: {
            formulations: {
              only: [ :name, :description, :quantity ],
              include: {
              feed: {
                only: [ :id, :name, :protein, :fiber, :fat ]
              }
            }
            }
          }
        )
      end

      private

      def animal_params
        params.require(:animal).permit(:name, :species, :age, :weight)
      end

      def set_animal
      @animal = Animal.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Animal not found" }, status: :not_found
    end
    end
  end
end
