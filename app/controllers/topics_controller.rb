class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    authorize @topics
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
    @bookmark = Bookmark.find(params[:id])
    authorize @topic
    authorize @bookmark
  end

  def new
    @topic = current_user.topics.new
    authorize @topic
  end

  def create
    @topic = current_user.topics.build(topics_params)
    authorize @topic
    topic = @topic.title
    if @topic.save
      flash[:notice] = "Your #{topic} was succesfully created"
      redirect_to @topic
    else
      flash[:error] = "Your #{topic} was not successfully created. Please try again."
      redirect_to new_topic_path
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic    
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    topic = @topic.title
    if @topic.update(topics_params)
      flash[:notice] = "Your #{topic} was succesfully updated"
      redirect_to @topic
    else
      flash[:error] = "Your #{topic} was not successfully updated. Please try again."
      redirect_to edit_topic_path
    end 
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    topic = @topic.title
    if @topic.destroy
      flash[:notice] = "Your #{topic} was succesfully updated"
      redirect_to @topic
    else
      flash[:error] = "Your #{topic} was not successfully deleted. Please try again."
      redirect_to topic_path
    end 

  end

  protected

  def topics_params
    params.require(:topic).permit(:title)
  end
end
