class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
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
    @users = User.all
  end

  def update
    @users = User.all
  	@wiki = Wiki.find(params[:id])
  	ids = params['col-ids'].split(",")
    puts ids.inspect
    ids.each do |id|
          Collaborator.create(user_id: id, wiki_id:(params[:id]))
    end

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
  	params.require(:wiki).permit(:title, :body, :private, :user_id)
  end

end
