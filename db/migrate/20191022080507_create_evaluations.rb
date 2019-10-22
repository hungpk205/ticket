class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.string :fullname
      t.string :phone
      t.string :identity_card
      t.text :content
      t.integer :score
      t.belongs_to :trip, foreign_key: true

      t.timestamps
    end
  end
end
