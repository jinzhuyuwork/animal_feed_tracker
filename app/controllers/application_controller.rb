class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Cookies

  before_action :authenticate_user!

  def authenticate_user!(opts = {})
    if user_signed_in?
      super
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
