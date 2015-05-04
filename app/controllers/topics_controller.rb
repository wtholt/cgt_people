class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find params[:id]
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new topic_params
    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_url, notice: "Topic successfully created"}
      else
        format.html { render :new }
      end
    end
  end

  def update
    @topic = Topic.find params[:id]
    @topic.update_attributes topic_params
  end

private
  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
