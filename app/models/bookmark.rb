class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 重複して登録を防ぐ。
  validates :user_id, uniqueness: { scope: :post_id }
end
