class CreatePlanificacions < ActiveRecord::Migration[5.0]
  def change
    create_table :planificacions do |t|
      t.integer :edifici_id
      t.integer :fons_propis
      t.integer :subvencions_solicitades
      t.integer :subvencions_atorgades
      t.integer :import_financar
      t.string :forma_financar
      t.string :data_financament

      t.timestamps
    end
  end
end
