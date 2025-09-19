class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Cookies

  before_action :log_ip

  def authenticate_user!(opts = {})
    if user_signed_in?
      super
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # This method checks if the current user is admin.
  def require_admin!
    unless current_user&.admin?
      render json: { error: "Access denied. Admins only." }, status: :forbidden
    end
  end


  private

  def log_ip
    Rails.logger.info "Request IP (request.ip): #{request.ip}, email: #{request.params.dig('user', 'email')&.downcase}"
    Rails.logger.info "Remote IP (request.remote_ip): #{request.remote_ip}"
  end
end
