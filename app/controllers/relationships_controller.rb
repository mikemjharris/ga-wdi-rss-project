class RelationshipsController < ApplicationController
 
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.follow!(@user)
    
    respond_to do |format|
      format.html { render '/users/index.html.erb' }
      format.js   { render '/users/index.js.erb'   }
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { render '/users/index.html.erb' }
      format.js   { render '/users/index.js.erb'   }
    end
  end
end