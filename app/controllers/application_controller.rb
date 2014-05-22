class ApplicationController < ActionController::Base
	include PublicActivity::StoreController
  protect_from_forgery
    
  layout :layout

  private

  def layout
    if controller_name == 'registrations' && action_name == 'new'
      'login'
    elsif controller_name == 'registrations' && action_name == 'create'
      'login'
    elsif controller_name == 'sessions' && action_name == 'new'
      'login'
    else
      'application'
    end
  end

end
