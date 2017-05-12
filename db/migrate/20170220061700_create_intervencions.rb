class CreateIntervencions < ActiveRecord::Migration[5.0]
  def change
    create_table :intervencions do |t|
      t.integer :edifici_id
      t.integer :fase_id
      t.text :descripcio
      t.string :sistema
      t.integer :import_obres, default: 0
      t.integer :import_honoraris, default: 0
      t.integer :import_taxes, default: 0
      t.integer :import_altres, default: 0
      t.integer :data_inici_any
      t.integer :data_inici_mes
      t.integer :durada_mesos

      t.timestamps
    end
  end
end
