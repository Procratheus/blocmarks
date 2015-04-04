class BookmarksController < ApplicationController
  before_action :set_topic
  before_action :set_bookmark, except: [:create, :new]
  require "embedly"
  require "json"

  def show
    @bookmark = Bookmark.find(params[:id])
    @url = embedly_url.oembed(url: @bookmark.url).first
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

  private

  def embedly_url
    embedly_api = Embedly::API.new :key => ENV["EMBEDLY_API_KEY"],
              :user_agent => "Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)"
  end 
end
