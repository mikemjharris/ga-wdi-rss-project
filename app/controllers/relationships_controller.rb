class RelationshipsController < ApplicationController
 
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.follow!(@user)
    @users = User.all
    respond_to do |format|
      format.js   { render '/users/index.js.erb'   }
      format.html { render '/users/index.html.erb' }
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow!(@user)
    @users = User.all
    respond_to do |format|
      format.js   { render '/users/index.js.erb'   }
      format.html { render '/users/index.html.erb' }
    end
  end
end