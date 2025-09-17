class Animal < ApplicationRecord
  has_many :formulations, dependent: :destroy
  has_many :feeds, through: :formulations
end
