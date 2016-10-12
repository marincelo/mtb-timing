class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def only_admin
    fail 'Access denied' unless current_user && current_user.admin
  end
end
