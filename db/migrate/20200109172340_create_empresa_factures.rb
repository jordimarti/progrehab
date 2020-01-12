class CreateEmpresaFactures < ActiveRecord::Migration[5.0]
  def change
    create_table :empresa_factures do |t|
      t.integer :user_id
      t.integer :edifici_id
      t.string :nom_juridic
      t.string :adreca
      t.string :poblacio
      t.string :provincia
      t.string :pais
      t.string :codi_postal
      t.string :email
      t.string :tipus_client
      t.string :nif

      t.timestamps
    end
  end
end
