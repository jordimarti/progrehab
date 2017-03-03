class Qualificacio < ApplicationRecord

	belongs_to :edifici
	
	has_attached_file :xml_file
  
	#validates_attachment_content_type :xml_file, :content_type => ["application/xml"]
	#No estic validant perquè els arxius xml de les ITEs no tenen header i no passen la validació
	do_not_validate_attachment_file_type :xml_file

end
