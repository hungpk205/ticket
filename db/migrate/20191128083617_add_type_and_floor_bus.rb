class AddTypeAndFloorBus < ActiveRecord::Migration[5.2]
  def change
    add_column :buses, :type_quality, :integer, default: 0
    add_column :buses, :type_floor, :integer, default: 0
  end
end
