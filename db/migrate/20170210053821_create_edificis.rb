class CreateEdificis < ActiveRecord::Migration[5.0]
  def change
    create_table :edificis do |t|
      t.integer :user_id
      t.string :nom_edifici

      t.timestamps
    end
  end
end
