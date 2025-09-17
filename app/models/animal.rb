class Animal < ApplicationRecord
  has_many :formulations
    has_many :feeds, through: :formulations
end
