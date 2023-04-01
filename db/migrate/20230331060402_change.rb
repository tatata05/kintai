class Change < ActiveRecord::Migration[6.1]
  def change
    add_index :admins, :email, unique: true
    add_index :employees, [:email, :phone_number], unique: true
    add_index :employees, :emergency_phone_number, unique: true
    remove_column :shifts, :status, :string
    remove_column :absences, :status, :string
    add_column :shifts, :status, :integer, default: 0
    add_column :absences, :status, :integer, default: 0
    change_column :notices, :read, :boolean, null: false
    rename_column :employees, :password_digest, :password
    rename_column :admins, :password_digest, :password
    rename_table :notices, :notifications
  end
end
