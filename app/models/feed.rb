class Feed < ApplicationRecord
	has_many :formulations
  	has_many :animals, through: :formulations
end
