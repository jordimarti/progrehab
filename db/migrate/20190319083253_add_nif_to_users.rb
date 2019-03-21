class AddNifToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :nif, :string
  end
end
