class LikesController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:bookmark_id])
    like = current_user.likes.build(bookamrk: @bookmark)
    if like.save
      flash[:notice] = "You successfully liked this bookmark"
      redirect_to @bookmark
    else
      flash[:error] = "There was a problem liking this bookmark. Please try again!"
      redirect_to @bookmark
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:bookmark_id])
    like = @bookmark.likes.find_by(user_id: current_user.id)
    if like.destroy
      flash[:notice] = "You successfully unliked this bookmark"
      redirect_to @bookmark
    else
      flash[:error] = "There was a problem unliking this bookmark. Please try again!"
      redirect_to @bookmark
    end

  end
end
