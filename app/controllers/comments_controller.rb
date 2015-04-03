class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      if @post.user.phone
        msg = Message.new(to: @post.user.phone, post: @post.title, comment: @comment.text)
        msg.send_sms
      end
      respond_to do |format|
        format.html do 
          flash[:notice] = "Comment submitted!"
          redirect_to post_path(@post)
        end
        format.js
      end
    else
      format.html do
        flash[:error] = "Comment not submitted!"
        render :new
      end
      format.js { render js: "alert('Comment not submitted!');" }
    end
    
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      respond_to do |format|
        format.html do
          flash[:notice] = "Comment updated!"
          redirect_to post_path(@post)
        end
        format.js
      end
    else
      format.html do
        flash[:error] = "Comment not updated!"
        render :edit
      end
      format.js { render js: "alert('Comment not updated!');" }
    end
    
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