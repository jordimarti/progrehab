class CreatePagaments < ActiveRecord::Migration[5.0]
  def change
    create_table :pagaments do |t|
    	t.integer :user_id
      t.integer :edifici_id
      t.string :numorder
      t.string :import
      t.string :resultado
      t.string :autorizacion
      t.boolean :pagat
      t.boolean :factura_enviada
      t.text :resposta_factura
      t.string :numorden
      t.string :num_factura_sap
      
      t.timestamps
    end
  end
end
