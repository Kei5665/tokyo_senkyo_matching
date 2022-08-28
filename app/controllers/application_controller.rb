# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def not_authenticated
    # Overwrite the method sorcery calls when it
    # detects a non-authenticated request.
    # Make sure that we reference the route from the main app.
    redirect_to main_app.login_path
  end
end
