class AddColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :shifts, :status, :string
    remove_column :absences, :status, :string
    add_column :shifts, :status, :integer, default: 0
    add_column :absences, :status, :integer, default: 0
  end
end
