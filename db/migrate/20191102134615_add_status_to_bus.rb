class AddStatusToBus < ActiveRecord::Migration[5.2]
  def change
    add_column :buses, :status, :integer, default: 0
  end
end
