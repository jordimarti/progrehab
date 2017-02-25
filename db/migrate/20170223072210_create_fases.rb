class CreateFases < ActiveRecord::Migration[5.0]
  def change
    create_table :fases do |t|
      t.integer :edifici_id
      t.string :nom
      t.integer :posicio
      t.text :observacions

      t.timestamps
    end
  end
end
