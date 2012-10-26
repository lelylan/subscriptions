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

  # Override the 401 notification method
  ActionController::HttpAuthentication::Basic.module_eval do
    def authentication_request(controller, realm)
      controller.render_401
    end
  end
end
