class HomesController < ApplicationController

  def top
    @posts = Post.page(params[:page]).reverse_order.per(6)
  end

end
