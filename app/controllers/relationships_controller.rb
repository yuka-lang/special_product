class RelationshipsController < ApplicationController

  # フォローするとき
  #通知の作成
  def create
    current_user.follow(params[:user_id])
    # @user = User.find(params[:following_id])
    # current_user.follow(@user)
    # @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

end
