class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :logo
      t.string :banner
      t.text :company_info
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
