class AddIndexTicket < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :booking, index: true, foreign_key: true
  end
end
