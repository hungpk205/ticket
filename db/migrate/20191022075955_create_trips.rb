class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.datetime :start_time
      t.integer :driver_major_id
      t.integer :driver_minor_id
      t.decimal :price
      t.belongs_to :route, foreign_key: true
      t.belongs_to :bus, foreign_key: true
      t.belongs_to :company, foreign_key: true

      t.timestamps
    end
  end
end
