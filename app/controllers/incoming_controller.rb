class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "INCOMING PARAMS HERE: #{params}"

    @user = User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])
    @body = params["body-plain"]

    if @user
      if @topic
        @bookmark = @topic.bookmarks.build(url: @body)
        @bookmark.save
      else
        @subject = @user.topics.build(title: params[:subject])
        @subject.save
        @bookmark = @subject.bookmarks.build(url: @body)
        @bookmark.save
      end
    end

    head 200
  end

end