class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.date :date, null: false
      t.string :starting_time, null: false
      t.string :ending_time, null: false
      t.integer :status, default: 0
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
