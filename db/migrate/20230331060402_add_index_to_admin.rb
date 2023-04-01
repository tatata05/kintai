class AddIndexToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_index :admins, :email, unique: true
  end
end
