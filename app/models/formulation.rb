class Formulation < ApplicationRecord
  belongs_to :animal
  belongs_to :feed

  validates :quantity, presence: true
end
