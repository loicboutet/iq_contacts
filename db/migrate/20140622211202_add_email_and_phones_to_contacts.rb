class AddEmailAndPhonesToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :email, :string
    add_column :contacts, :mobile_phone, :string
    add_column :contacts, :landline_phone, :string
  end
end
