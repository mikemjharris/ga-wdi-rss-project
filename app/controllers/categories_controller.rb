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
      @subscriptions = Subscription.where(category_id: params[:id])
      @subscriptions.each{ |s| s.category_id = nil; s.save}
			
      Category.find(params[:id]).destroy
			# redirect_to :root

	end

	def show
		@user = current_user
		@category = Category.find(params[:id])
		@articles = @user.articles.where("subscriptions.category_id = #{params[:id]}").most_recent
		
		respond_to do |format|
      format.js  {render 'show.js.erb'}
      format.html 
    end
	end


end