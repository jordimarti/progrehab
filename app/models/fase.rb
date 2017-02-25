class Fase < ApplicationRecord

	belongs_to :edifici
	has_many :intervencions

end
