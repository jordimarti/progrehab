class CreateIntervencions < ActiveRecord::Migration[5.0]
  def change
    create_table :intervencions do |t|
      t.integer :edifici_id
      t.integer :fase_id
      t.text :descripcio
      t.string :sistema
      t.integer :import_obres
      t.integer :import_honoraris
      t.integer :import_taxes
      t.integer :import_altres

      t.timestamps
    end
  end
end
