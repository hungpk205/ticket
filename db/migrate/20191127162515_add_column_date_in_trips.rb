class AddColumnDateInTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :start_day_readonly, :date, default: Time.now.to_date
  end
end
