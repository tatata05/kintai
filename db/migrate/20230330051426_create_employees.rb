class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :gender
      t.integer :age
      t.string :address
      t.string :phone_number, unique: true
      t.string :emergency_phone_number
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
