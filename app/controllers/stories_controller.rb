class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def stats
    response = {}
    response['hello'] = "world"
    render json: JSON[response]
  end
end
