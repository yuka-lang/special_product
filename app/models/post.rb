class Post < ApplicationRecord

  # コメント機能のアソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy

  # タグ機能のアソシエーション
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # ブックマーク機能のアソシエーション
  has_many :bookmarks, dependent: :destroy

  # いいね機能のアソシエーション
  has_many :favorites, dependent: :destroy


  # すでにブックマーク登録済みかを判定
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # すでにいいね登録済みかを判定
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
