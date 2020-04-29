class AddIteToUsuariFactures < ActiveRecord::Migration[5.0]
  def change
    add_column :usuari_factures, :num_visat_ite, :string
  end
end
