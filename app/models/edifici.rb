class Edifici < ApplicationRecord

	has_one :identificacio
	has_one :qualificacio
	has_many :deficiencies
	belongs_to :user

end
