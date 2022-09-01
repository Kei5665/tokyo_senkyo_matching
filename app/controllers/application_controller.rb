# frozen_string_literal: true

class ApplicationController < ActionController::Base

  private

    def not_authenticated
      # Overwrite the method sorcery calls when it
      # detects a non-authenticated request.
      # Make sure that we reference the route from the main app.
      redirect_to main_app.login_path
    end
end
