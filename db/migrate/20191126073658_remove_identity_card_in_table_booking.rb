class RemoveIdentityCardInTableBooking < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :identity_card
  end
end
