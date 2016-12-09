class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def main
  end

  protected

  def after_sign_in_path_for(resource)
    api_v1_user_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
