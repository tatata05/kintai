class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.boolean :read, null: false, default: false
      t.references :employee, null: true, foreign_key: true
      t.references :shift, null: true, foreign_key: true
      t.references :absence, null: true, foreign_key: true
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
