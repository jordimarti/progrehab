class Qualificacio < ApplicationRecord

	belongs_to :edifici
	
	has_attached_file :xml_file
	before_save :parse_file
	#validates_attachment_content_type :xml_file, :content_type => ["application/xml"]
	#No estic validant perquè els arxius xml de les ITEs no tenen header i no passen la validació
	do_not_validate_attachment_file_type :xml_file

	def parse_file
    tempfile = xml_file.queued_for_write[:original]
    doc = Nokogiri::XML(tempfile)
    parse_xml(doc)
  end

  def parse_xml(doc)
    doc.root.elements.each do |node|
      parse_deficiencies(node)
    end
  end

  def parse_deficiencies(node)
    if node.node_name.eql? 'deficiencies'
      deficiencia = Deficiencia.new
      deficiencia.edifici_id = 1
      node.elements.each do |node|
        deficiencia.descripcio = node.text.to_s if node.name.eql? 'deficienciaDescripcio'
        deficiencia.observacions = node.text.to_s if node.name.eql? 'deficienciaObservacions'
        if node.name.eql? 'gravetat'
					node.elements.each do |node|
        		deficiencia.qualificacio = node.text.to_s if node.name.eql? 'valor'
        	end
        end
      end
      deficiencia.save
    end
  end

end
