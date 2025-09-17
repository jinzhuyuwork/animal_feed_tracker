module Api
  module V1
    class AnimalsController < ApplicationController
      def index
        animals = Animal.all
        render json: animals
      end

      def show
        animal = Animal.find(params[:id])
        render json: animal, include: :feeds
      end

      def create
        animal = Animal.new(animal_params)
        if animal.save
          render json: animal, status: :created
        else
          render json: animal.errors, status: :unprocessable_entity
        end
      end

      private

      def animal_params
        params.require(:animal).permit(:name, :species, :age, :weight)
      end
    end
  end
end

