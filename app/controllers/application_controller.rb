class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
    if user_signed_in?
      flash[:error] = t "check.no_permission"
      redirect_to root_path
    else
      flash[:error] = t "check.require_login"
      redirect_to new_user_session_url
    end
  end



  protected
  def configure_permitted_parameters
    added_attrs = [:fullname, :phone, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def load_company
    @company = current_user.company
  end

  def load_notifications
    if current_user.company.present?
      @notifications = current_user.company.notifications.newest.limit(5)
    end
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def default_url_options
    {locale: I18n.locale}
  end
end
