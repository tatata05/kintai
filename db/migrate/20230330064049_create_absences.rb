class CreateAbsences < ActiveRecord::Migration[6.1]
  def change
    create_table :absences do |t|
      t.string :status, default: "未承認"
      t.references :shift, null: false, foreign_key: true

      t.timestamps
    end
  end
end
