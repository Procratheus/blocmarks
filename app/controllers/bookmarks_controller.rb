class BookmarksController < ApplicationController
  before_action :set_topic
  before_action :set_bookmark, except: [:create, :new]

  def show
    
  end

  def new
    
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.build(bookmark_params)
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  protected

  def bookmark_params
    params.require(:bookmark).permit(:title, :url)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
