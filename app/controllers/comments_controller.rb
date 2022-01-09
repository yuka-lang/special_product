class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :comments  #render先にjsファイルを指定
    else
      render 'posts/show'
    end
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    @post = Post.find(params[:post_id])
    render :comments
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

end
