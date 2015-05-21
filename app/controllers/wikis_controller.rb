class WikisController < ApplicationController
  def index
  	@wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @wikis
  end

  def show
  	@wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
	@wiki = Wiki.new
  end

  def create
  	@wiki = current_user.wikis.new(wiki_params)
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
  	params.require(:wiki).permit(:title, :body, :private)
  end

end
