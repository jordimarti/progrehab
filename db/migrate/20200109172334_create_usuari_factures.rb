class CreateUsuariFactures < ActiveRecord::Migration[5.0]
  def change
    create_table :usuari_factures do |t|
      t.integer :user_id
      t.integer :edifici_id
      t.string :nom
      t.string :adreca
      t.string :poblacio
      t.string :provincia
      t.string :pais
      t.string :codi_postal
      t.string :email
      t.string :num_client
      t.boolean :colegiat
      t.string :nif

      t.timestamps
    end
  end
end
