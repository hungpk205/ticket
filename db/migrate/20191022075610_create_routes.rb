class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :start_place
      t.string :end_place
      t.text :detail
      t.belongs_to :company, foreign_key: true

      t.timestamps
    end
  end
end
