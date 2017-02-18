class Qualificacio < ApplicationRecord

	belongs_to :edifici
	
	has_attached_file :xml_file
	validates_attachment_content_type :xml_file, :content_type => ["application/xml"]

end
