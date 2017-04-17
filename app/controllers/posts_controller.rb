class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:user_index, :new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def show
  end

  def index
    @total_tags = Tag.all.sort_by(&:name)
    if params[:tag].present? && Tag.find_by_name(params[:tag]).present?
      @posts = Tag.find_by_name(params[:tag]).posts
    else
      @posts = Post.all
    end
  end

  def user_index
    @total_tags = Tag.all.sort_by(&:name)
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
    @post.tag_string = @post.tags.pluck(:name).join(", ")
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
    params.require(:post).permit(:title, :body, :tag_string)
  end

end
