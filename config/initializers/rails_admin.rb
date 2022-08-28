RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Sorcery ==
  config.authenticate_with do
    # Use sorcery's before filter to auth users
    # pathはmain_app.XX_pathの形式が必要
    require_login
    # redirect_to main_app.login_path
  end
  config.current_user_method(&:current_user)
  config.parent_controller = 'ApplicationController' #追記

  ## == CancanCan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
