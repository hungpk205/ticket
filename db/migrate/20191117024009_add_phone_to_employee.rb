class AddPhoneToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :phone, :string
  end
end
