class RemoveTypeFloorBus < ActiveRecord::Migration[5.2]
  def change
    remove_column :buses, :type_floor
  end
end
