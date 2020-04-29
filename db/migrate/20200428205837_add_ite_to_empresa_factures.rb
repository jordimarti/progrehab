class AddIteToEmpresaFactures < ActiveRecord::Migration[5.0]
  def change
    add_column :empresa_factures, :num_visat_ite, :string
  end
end
