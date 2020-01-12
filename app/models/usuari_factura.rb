class UsuariFactura < ApplicationRecord

	belongs_to :edifici

	validates :nif, presence: true
	validates :nif, format: { with: /\A[0-9]{8}[A-Z]\Z/,
    message: "NIF incorrecte" }
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :nom, presence: true
  validates :adreca, presence: true
  validates :poblacio, presence: true
  validates :provincia, presence: true
  validates :codi_postal, presence: true

end
