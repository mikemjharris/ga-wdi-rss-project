class ArticlesController < ApplicationController

  def index
    
     @articles = Article.all

  end

	def create
		raise
	end

  def show
      @article = Article.find(params[:id])
      respond_to do |format|
    	format.js {render 'show.js.erb'}
    	format.html {render 'show.html.erb'}
   	end	

  end

  









end