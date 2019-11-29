class AddEndTimeReadonlyToTrip < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :end_time_readonly, :date
  end
end
