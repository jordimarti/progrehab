class Edifici < ApplicationRecord

	has_one :identificacio
	has_one :qualificacio
	has_many :deficiencies
	has_many :intervencions
	belongs_to :user

end
