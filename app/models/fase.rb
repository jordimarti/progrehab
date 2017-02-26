class Fase < ApplicationRecord

	belongs_to :edifici
	has_many :intervencions
	has_many :derrames

end
