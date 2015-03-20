class CommentsController < ApplicationController

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "Comment submitted!"
    else
      flash[:error] = "Comment not submitted!"
    end
    redirect_to post_path(@post) 
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated!"
    else
      flash[:error] = "Comment not updated!"
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment exterminated!"
    redirect_to post_path(@post)
  end


private
  def comment_params
    params.require(:comment).permit(:text)
  end

end