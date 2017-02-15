class Edifici < ApplicationRecord

	has_one :identificacio
	belongs_to :user

end
