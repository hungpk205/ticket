module HomepagesHelper
  def unread_notification company
    @company = company
    return 0 unless @company.present?
    @company.notifications.unread.size
  end
end
