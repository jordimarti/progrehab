class CreateQualificacions < ActiveRecord::Migration[5.0]
  def change
    create_table :qualificacions do |t|
      t.integer :edifici_id

      t.timestamps
      
    end
  end
end
