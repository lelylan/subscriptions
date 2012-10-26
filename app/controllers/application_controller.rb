class ApplicationController < ActionController::Base
  include Resourceable
  include Rescueable
  include Viewable

  before_filter :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |uid, secret|
      @current_app = Doorkeeper::Application.where(uid: uid, secret: secret).first
      @current_app == nil ? false : true
    end
  end
  
  def current_app
    @current_app
  end
end
