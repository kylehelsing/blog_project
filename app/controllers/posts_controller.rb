class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def show
  end

  def index
    if params[:tag].present?

    else
      @posts = Post.all
    end
  end

  def user_index
    @posts = Post.where(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to user_posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to user_posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to user_posts_path, notice: 'Post was successfully deleted.'
    end
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body, :tag)
  end

end
