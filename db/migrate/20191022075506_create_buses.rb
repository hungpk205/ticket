class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses do |t|
      t.string :license_plate
      t.integer :slot
      t.belongs_to :company, foreign_key: true

      t.timestamps
    end
  end
end
