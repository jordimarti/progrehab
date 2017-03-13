class AddAttachmentFotoFacanaToIdentificacions < ActiveRecord::Migration
  def self.up
    change_table :identificacions do |t|
      t.attachment :foto_facana
    end
  end

  def self.down
    remove_attachment :identificacions, :foto_facana
  end
end
