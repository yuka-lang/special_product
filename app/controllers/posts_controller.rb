class PostsController < ApplicationController

  before_action :sidebar
  before_action :ranking, only: [:index, :search, :search_tag]
  before_action :set_edit_tags, only: [:edit, :update]
  before_action :set_new_tags, only: [:new, :create]

  def new
    @post = Post.new

    tag_tops = PostTag.joins(:tag)
                      .group(:tag_id)
                      .select("tag_id, count(tag_id) AS count, tags.name")
                      .order("count desc")
                      .limit(5)

    @top = []  #空の配列を作る
    tag_tops.each do |tag_top|
      # idとタグ名を配列に足していく
      @top.push([tag_top.tag.id, tag_top.tag.name])
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    # 受け取った値を,で区切って配列にする
    tag_list = params[:post][:names].split(',')
    if @post.save
      # binding.irb
      @post.save_tag(tag_list)
      params[:post][:tag_ids].each do |tag_id|
        PostTag.create(post_id: @post.id, tag_id: tag_id)
      end
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order.per(6)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.all
    @post_tags = @post.tags
    @user = current_user
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name)
    # 名前を配列で返す

    tag_tops = PostTag.joins(:tag)
                      .group(:tag_id)
                      .select("tag_id, count(tag_id) AS count, tags.name")
                      .order("count desc")
                      .limit(5)

    @top = []
    top_for_edit = []
    tag_tops.each do |tag_top|
      @top.push([tag_top.tag.id, tag_top.tag.name])
      # idと名前を配列に足していく
      top_for_edit.push(tag_top.tag.name)
    end

    @tag_list = (@tag_list - top_for_edit).join(',')
    #チェックボックス以外のタグをフォームに表示する

  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:names].split(',')
    if @post.update(post_params)
      # byebug
      @post.save_tag(tag_list)
      params[:post][:tag_ids].each do |tag_id|
        PostTag.create(post_id: @post.id, tag_id: tag_id)
      end
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
    @posts = @tag.posts.all
  end

  # 検索機能
  def search
    # キーワードを探しpaginationを利用
    @posts = Post.search(params[:keyword]).page(params[:page]).per(6)
    @keyword = params[:keyword]
    render "index"
  end

  def sidebar
    @tag_lists = PostTag.joins(:tag)
                        .group(:tag_id)
                        .select("tag_id, count(tag_id) AS count, tags.name")
                        .order("count desc")
                        .limit(5)
  end

  def ranking
    # Favoriteモデルから今週のデータを取り出し、数の多い順に並び替えたpost_idの値をPostモデルから探す(３位までを表示)
    @week_post_favorite_ranks = Post.find(
      Favorite.group(:post_id)
              .where(created_at: Time.current.all_week)
              .order("count(post_id) desc")
              .limit(3)
              .pluck(:post_id)
    )

    #上記と同じように月間のコメント数の多い順で表示する
    @month_post_comment_ranks = Post.find(
      Comment.group(:post_id)
            .where(created_at: Time.current.all_month)
            .order("count(user_id) desc")
            .limit(3)
            .pluck(:post_id)
    )
  end


  private

  def post_params
    params.require(:post).permit(:title, :image, :prefectures, :season, :word, :introduction, tag_ids: [])
  end

  # 編集時のbefore_actionのメソッド
  def set_edit_tags
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name)
    # 名前を配列で返す

    tag_tops = PostTag.joins(:tag)
                      .group(:tag_id)
                      .select("tag_id, count(tag_id) AS count, tags.name")
                      .order("count desc")
                      .limit(5)

    @top = []
    top_for_edit = []
    tag_tops.each do |tag_top|
      @top.push([tag_top.tag.id, tag_top.tag.name])
      # idと名前を配列に足していく
      top_for_edit.push(tag_top.tag.name)
    end

    @tag_list = (@tag_list - top_for_edit).join(',')
    #チェックボックス以外のタグをフォームに表示する
  end
  
  
  # 保存時のbefore_actionのメソッド
  def set_new_tags
    @post = Post.new

    tag_tops = PostTag.joins(:tag)
                      .group(:tag_id)
                      .select("tag_id, count(tag_id) AS count, tags.name")
                      .order("count desc")
                      .limit(5)

    @top = []  #空の配列を作る
    tag_tops.each do |tag_top|
      # idとタグ名を配列に足していく
      @top.push([tag_top.tag.id, tag_top.tag.name])
    end
  end

end
