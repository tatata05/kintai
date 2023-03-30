class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :status, default: "未承認"
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
