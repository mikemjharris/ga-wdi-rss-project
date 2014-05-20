class CategoriesController < ApplicationController

	def create
		@user = current_user
		@category = Category.new()
		
		@category.category_name = params[:category_name]
		@category.user_id = @user.id
		@category.save

		respond_to do |format|
      format.js  {render 'create.js.erb'}
      format.html {redirect_to :root}
    end
	end


	def destroy
			Subscription.find(params[:id]).destroy

			redirect_to :root

	end



end