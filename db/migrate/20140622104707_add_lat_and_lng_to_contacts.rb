class AddLatAndLngToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :lat, :decimal
    add_column :contacts, :lng, :decimal
    add_index :contacts, :lat
    add_index :contacts, :lng
  end
end
