class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def show
    @comment = @commentable.new comment_params

    if @comment.save
      redirect_to :back, notice: 'Your comment was successfully posted!'
    else
      redirect_to :back, notice: 'Your comment wasnt posted!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)    
  end

  def find_commentable
    @commentable = if params[:story_id]
      Story.find(params[:story_id])
    else
      Comment.find(params[:comment_id])
    end
  end
end