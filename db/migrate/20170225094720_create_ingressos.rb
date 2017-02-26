class CreateIngressos < ActiveRecord::Migration[5.0]
  def change
    create_table :ingressos do |t|
      t.integer :edifici_id
      t.integer :fase_id
      t.integer :valor
      t.integer :data_mes
      t.integer :data_any

      t.timestamps
    end
  end
end
