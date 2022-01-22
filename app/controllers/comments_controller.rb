class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    # p @comment
    @comment.post_id = @post.id
    if @comment.save
      #コメント通知の呼び出し
      @post.create_notification_comment!(current_user, @comment.id)
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
