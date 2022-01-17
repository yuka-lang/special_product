class PostsController < ApplicationController

  def new
    @post = Post.new
    @tag_lists = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag_lists = Tag.all
    # 受け取った値を,で区切って配列にする
    tag_list = params[:post][:names].split(',')
    if @post.save
       @post.save_tag(tag_list)
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order.per(6)
    # Favoriteモデルから今週のデータを取り出し、数の多い順に並び替えたpost_idの値をPostモデルから探す(３位までを表示)
    @week_post_favorite_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order("count(post_id) DESC").limit(3).pluck(:post_id))
    #上記と同じように月間のコメント数の多い順で表示する
    @month_post_comment_ranks = Post.find(Comment.group(:post_id).where(created_at: Time.current.all_month).order("count(user_id) DESC").limit(3).pluck(:user_id))
    @tag_lists = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.all
    @post_tags = @post.tags
    @user = current_user
    @tag_lists = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
    @tag_lists = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    @tag_lists = Tag.all
    tag_list = params[:post][:names].split(',')
    if @post.update(post_params)
       @post.save_tag(tag_list)
       flash[:notice] = '更新に成功しました！'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  # ブックマーク一覧を表示する
  def bookmarks
    @bookmarks = Bookmark.where(user_id: current_user.id).all
    @user = current_user
  end

  # タグ検索画面
  def search_tag
    @tag = Tag.find(params[:tag_id])
    @tag_lists = Tag.all
    @posts = @tag.posts.all
     # Favoriteモデルから今週のデータを取り出し、数の多い順に並び替えたpost_idの値をPostモデルから探す
    @week_post_favorite_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) DESC').limit(3).pluck(:post_id))
    #上記と同じように月間のコメント数の多いランキングを表示する
    @month_post_comment_ranks = Post.find(Comment.group(:post_id).where(created_at: Time.current.all_month).order("count(user_id) DESC").limit(3).pluck(:user_id))
  end

  # 検索機能
  def search
    # キーワードを探しpaginationを利用
    @posts = Post.search(params[:keyword]).page(params[:page]).per(6)
    @keyword = params[:keyword]
    @tag_lists = Tag.all
     # Favoriteモデルから今週のデータを取り出し、数の多い順に並び替えたpost_idの値をPostモデルから探す
    @week_post_favorite_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) DESC').limit(3).pluck(:post_id))
    #上記と同じように月間のコメント数の多いランキングを表示する
    @month_post_comment_ranks = Post.find(Comment.group(:post_id).where(created_at: Time.current.all_month).order("count(user_id) DESC").limit(3).pluck(:user_id))
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :prefectures, :season, :word, :introduction)
  end

end
