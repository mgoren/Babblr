class CommentsController < ApplicationController

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


private
  def comment_params
    params.require(:comment).permit(:text)
  end

end