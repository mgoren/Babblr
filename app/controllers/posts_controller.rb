class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post successfully added!"
      redirect_to post_path(@post)
    else
      flash[:error] = "Please fill out title and body."
      render :new
    end
  end

private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
