class HomepagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_notifications

  def home

  end
end
