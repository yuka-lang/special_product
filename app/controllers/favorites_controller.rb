class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(post_id: @post.id)
    if @favorite.save
    # 非同期通信を適用
    else
      redirect_to request.referer
    end
    #通知機能を呼び出す
    @post.create_notification_like!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    if @favorite.destroy
    # 非同期通信を適用
    else
      redirect_to request.referer
    end
  end
end
