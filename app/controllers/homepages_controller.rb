class HomepagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_company
  before_action :load_notifications

  def home
    @count_paying = 0
    @count_paid = 0
    if @company.present?
      @trips = @company.trips
      @trips.each do |trip|
        @count_paying += trip.bookings.paying.size
        @count_paid += trip.bookings.paid.size
      end
    end
    if current_user.admin?
      @users = User.non_admin
    end
  end
end
