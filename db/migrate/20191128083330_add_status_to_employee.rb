class AddStatusToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :status, :integer, default: 0
  end
end
