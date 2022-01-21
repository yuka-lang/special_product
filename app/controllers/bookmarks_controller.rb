class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @bookmark = @post.bookmarks.new(user_id: current_user.id)
    if @bookmark.save
    # 非同期通信
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @bookmark = @post.bookmarks.find_by(user_id: current_user.id)
    if @bookmark.present?
      @bookmark.destroy
      # 非同期通信
    else
      redirect_to request.referer
    end
  end
end
