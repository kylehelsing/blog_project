class CommentsController < ApplicationController

  def index
    @comments = Post.find(params[:post_id]).comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])

    if @comment.save
      redirect_to post_path(params[:post_id]), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    if @comment.destroy
      redirect_to user_posts_path, notice: 'Post was successfully deleted.'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body)
  end

end
