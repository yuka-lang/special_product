class Post < ApplicationRecord
  belongs_to :user

  # 画像投稿用
  attachment :image

  # コメント機能のアソシエーション
  has_many :comments, dependent: :destroy

  # タグ機能のアソシエーション
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # ブックマーク機能のアソシエーション
  has_many :bookmarks, dependent: :destroy

  # いいね機能のアソシエーション
  has_many :favorites, dependent: :destroy

  # レビュー機能のアソシエーション
  has_many :reviews, dependent: :destroy
  
  #通知モデルとのアソシエーション
  has_many :notifications, dependent: :destroy

  # 投稿のバリデーション
  validates :image, presence: true
  validates :title, presence: true
  validates :prefectures, presence: true
  validates :season, presence: true
  validates :introduction, presence: true
  validates :word, presence: true

  # すでにブックマーク登録済みかを判定
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # すでにいいね登録済みかを判定
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # タグ付けのメソッドを定義
  def save_tag(tag_list)
    # すでにタグ登録していた場合、紐ずくタグの削除
    if !tags.nil?
      post_tags_records = PostTag.where(post_id: id)
      post_tags_records.destroy_all
    end

    tag_list.each do |tag|
      # 既にタグが保存されていればレコードを取得し、されてなければ保存する
      inspected_tag = Tag.where(name: tag).first_or_create
      tags << inspected_tag
    end
  end

  # 探索機能の検索内容を表示
  def self.search(search)
    if search != ""
      Post.where(['title LIKE(?) OR introduction LIKE(?) OR  season LIKE(?) OR prefectures LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      all
    end
  end
  
  #通知機能（いいね）
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end
  
end
