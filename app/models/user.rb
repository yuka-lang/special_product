class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # コメント機能のアソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # DM機能のアソシエーション
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  # ブックマーク機能のアソシエーション
  has_many :bookmarks, dependent: :destroy

  # いいね機能のアソシエーション
  has_many :favorites, dependent: :destroy

end
