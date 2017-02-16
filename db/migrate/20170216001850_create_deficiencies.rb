class CreateDeficiencies < ActiveRecord::Migration[5.0]
  def change
    create_table :deficiencies do |t|
      t.integer :edifici_id
      t.text :descripcio
      t.text :observacions
      t.string :sistema
      t.string :qualificacio

      t.timestamps
    end
  end
end
