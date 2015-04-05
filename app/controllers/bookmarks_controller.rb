class BookmarksController < ApplicationController
  before_action :set_topic
  before_action :set_bookmark, except: [:create, :new]
  require "embedly"
  require "json"

  def show
    @url = embedly_url.oembed(url: @bookmark.url).first
  end

  def new  
    @bookmark = @topic.bookmarks.new
    authorize @bookmark
  end

  def create
    @bookmark = @topic.bookmarks.build(bookmark_params)
    authorize @bookmark
    if @bookmark.save
      flash[:notice] = "Your bookmark was sucessfully created"
      redirect_to @topic
    else
      flash[:error] = "There was a problem creating your bookmark. Please try again."
      redirect_to @topic
    end    
  end

  def edit
    authorize @bookmark
  end

  def update
    authorize @bookmark
    if @bookmark.update
      flash[:notice] = "Your bookmark was succesfully updated"
      redirect_to @topic
    else
      flash[:error] = "There was a problem updating your bookmark. Please try again."
      redirect_to @bookmark
    end    
  end

  def destroy
    authorize @bookmark
    if @bookmark.destroy
      flash[:notice] = "Your bookmark was successfully deleted."
      redirect_to @topic
    else
      flash[:error] = "There was problem deleting your bookmark. Please try again."
      redirect_to @bookmark    
    end
  end

  protected

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  private

  def embedly_url
    embedly_api = Embedly::API.new :key => ENV["EMBEDLY_API_KEY"],
              :user_agent => "Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)"
  end 
end
