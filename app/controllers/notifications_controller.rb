class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_company

  def index
    @notifications = @company.notifications.newest.page(params[:page]).per(10)
  end
end
