class UsersController < ApplicationController

before_filter :authenticate_user!

def index
	@feeds = Feed.all
end

end