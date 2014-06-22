class AddAddressCountryToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :address_country, :string
  end
end
