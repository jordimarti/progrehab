class AddAttachmentXmlFileToQualificacions < ActiveRecord::Migration
  def self.up
    change_table :qualificacions do |t|
      t.attachment :xml_file
    end
  end

  def self.down
    remove_attachment :qualificacions, :xml_file
  end
end
