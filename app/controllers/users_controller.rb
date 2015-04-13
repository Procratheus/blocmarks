class UsersController < ApplicationController

  def show
    @user_bookmarks = current_user.topics
    @user_likes = current_user.likes
    @bookmarks = @user_likes.map(&:bookmark).group_by(&:topic)
  end

end
