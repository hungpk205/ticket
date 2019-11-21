class Notification < ApplicationRecord
  after_create_commit :push_notify
  belongs_to :company

  scope :newest, ->{order(created_at: :desc)}
  scope :unread, ->{where(status: :unread)}

  enum status: %i(unread readed)

  private

  def push_notify
    ActionCable.server.broadcast "notification_channel", notification: render_notification(self)
  end

  def render_notification notification
    ApplicationController.renderer.render partial: "notifications/notification", locals: {notification: notification}
  end
end
