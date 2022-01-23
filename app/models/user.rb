class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }

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

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  #自分からの通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  #相手からの通知
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  # プロフィール画像投稿用
  attachment :profile_image

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
  # フォローの通知
  def create_notification_follow!(current_user)
    # レコードの存在をチェック
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
end
