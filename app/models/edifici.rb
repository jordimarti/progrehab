class Edifici < ApplicationRecord

	has_one :identificacio
	has_one :qualificacio
	has_many :deficiencies
	has_many :intervencions
	has_many :fases
	has_one :planificacio
	has_many :ingressos
	belongs_to :user

end
