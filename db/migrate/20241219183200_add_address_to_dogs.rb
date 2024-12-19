class AddAddressToDogs < ActiveRecord::Migration[7.2]
  def change
    add_column :dogs, :street, :string
    add_column :dogs, :city, :string
    add_column :dogs, :province, :string
    add_column :dogs, :postal_code, :string
  end
end
