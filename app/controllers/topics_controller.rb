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
    @topic = Topic.create topic_params
    redirect_to topics_path
  end

private
  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
