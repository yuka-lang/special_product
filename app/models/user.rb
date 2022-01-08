class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 投稿用のアソシエーション
  has_many :posts, dependent: :destroy

  # コメント機能のアソシエーション
  has_many :comments, dependent: :destroy

  # DM機能のアソシエーション
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  # ブックマーク機能のアソシエーション
  has_many :bookmarks, dependent: :destroy

  # いいね機能のアソシエーション
  has_many :favorites, dependent: :destroy

  # プロフィール画像投稿用
  attachment :profile_image

end
