class Tag < ApplicationRecord
  
  # タグ機能のアソシエーション
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags
end
