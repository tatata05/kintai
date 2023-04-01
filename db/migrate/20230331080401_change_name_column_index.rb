class ChangeNameColumnIndex < ActiveRecord::Migration[6.1]
  def change
    change_column :notices, :read, :boolean, null: false
    rename_column :employees, :password_digest, :password
    rename_column :admins, :password_digest, :password
    rename_table :notices, :notifications
  end
end
