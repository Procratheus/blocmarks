class UsersController < ApplicationController

  def show
    @user_bookmarks = current_user.topics
    @user_likes = current_user.likes
  end

end
