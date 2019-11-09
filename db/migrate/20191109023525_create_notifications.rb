class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.text :content
      t.integer :status
      t.integer :url_id
      t.references :company, foreign_key: true
    end
  end
end
