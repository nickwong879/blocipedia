class WikisController < ApplicationController
  def index
  	@wikis = Wiki.all
  end

  def show
  	@wiki = Wiki.find(params[:id])
  end

  def new
	@wiki = Wiki.new
  end

  def create
  	@wiki = Wiki.new(wiki_params)
  	if @wiki.save
  		flash[:notice] = "Wiki created"
  		redirect_to @wiki
  	else
  		flash[:error] = "Error saving wiki, please try again."
  		render :new
  	end
  end

  def edit
  	@wiki = Wiki.find(params[:id])
  end

  def update
  	@wiki = Wiki.find(params[:id])
  	if @wiki.update_attributes(wiki_params)
  		flash[:notice] = "Wiki updated"
  		redirect_to @wiki
  	else
  		flash[:error] = "Error saving wiki, please try again."
  		render :edit
  	end
  end


private

  def wiki_params
  	params.require(:wiki).permit(:title, :body)
  end

end
