class AddIndexToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_index :employees, [:email, :phone_number], unique: true
    add_index :employees, :emergency_phone_number, unique: true
  end
end
