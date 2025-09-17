class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Cookies

  before_action :authenticate_user!
end
