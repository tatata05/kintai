class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.boolean :read, default: false
      t.references :employee, null: true, foreign_key: true
      t.references :shift, null: true, foreign_key: true
      t.references :absence, null: true, foreign_key: true

      t.timestamps
    end
  end
end
