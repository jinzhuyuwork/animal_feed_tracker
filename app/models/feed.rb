class Feed < ApplicationRecord
  has_many :formulations, dependent: :destroy
  has_many :animals, through: :formulations
end
