class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :comments  # render先にjsファイルを指定
    else
      render 'posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :comments
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

end
