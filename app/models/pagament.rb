class Pagament < ActiveRecord::Base

	belongs_to :edifici
	belongs_to :user

end
