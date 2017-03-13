class Identificacio < ApplicationRecord

	belongs_to :edifici

	has_attached_file :foto_facana, :styles => { :original => "600x600>", :medium => "400x400>", :thumb => "200x200!" }, :default_url => "https://s3-eu-west-1.amazonaws.com/llibreedifici/missing/missing_facana.png"
  validates_attachment_content_type :foto_facana, :content_type => /\Aimage\/.*\Z/

end
