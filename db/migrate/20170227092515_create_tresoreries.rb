class CreateTresoreries < ActiveRecord::Migration[5.0]
  def change
    create_table :tresoreries do |t|
      t.integer :edifici_id
      t.integer :import
      t.integer :data_mes
      t.integer :data_any

      t.timestamps
    end
  end
end
