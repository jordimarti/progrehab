class EmpresaFactura < ApplicationRecord

	belongs_to :edifici

	validates :nif, presence: true
	validates :email, presence: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
	validates :nom_juridic, presence: true
  validates :adreca, presence: true
  validates :poblacio, presence: true
  validates :provincia, presence: true
  validates :codi_postal, presence: true

end
