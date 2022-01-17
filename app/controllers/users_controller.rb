class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(created_at: :desc)
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "更新に成功しました！"
    else
      flash[:alert] = "更新に失敗しました...もう一度入力してください。"
      redirect_to request.referer
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
