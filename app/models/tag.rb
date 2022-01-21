class Tag < ApplicationRecord
  # タグ機能のアソシエーション
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, uniqueness: true
  validates :name, presence: true
end
