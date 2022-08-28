# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def not_authenticated
    # Overwrite the method sorcery calls when it
    # detects a non-authenticated request.
    # Make sure that we reference the route from the main app.
    # login_pathが必要
    # redirect_to login_path, , warning: "管理者権限が必要です。ログインしてください"
  end
end
