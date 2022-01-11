class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:post][:names].split(',')
    if @post.save
       @post.save_tag(tag_list)
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @tag_list = Tag.all
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
    @tag_list=@post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:names].split(',')
    if @post.update(post_params)
       @post.save_tag(tag_list)
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
    @tag_lists = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts=@tag.posts.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :prefectures, :season, :word, :introduction)
  end

end
