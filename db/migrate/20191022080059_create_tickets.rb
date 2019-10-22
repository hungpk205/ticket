class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :code
      t.integer :status
      t.belongs_to :trip, foreign_key: true

      t.timestamps
    end
  end
end
