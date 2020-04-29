class AddIteToPagaments < ActiveRecord::Migration[5.0]
  def change
    add_column :pagaments, :num_visat_ite, :string
  end
end
