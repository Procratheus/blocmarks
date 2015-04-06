class UsersController < ApplicationController

  def show
    @user_bookmarks = current_user.topics.bookmarks
    @liked_bookmarks = current_user.likes.find_by(user_id: current_user.id)
  end

end
