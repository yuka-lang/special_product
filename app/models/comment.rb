class Comment < ApplicationRecord
  # コメント機能のアソシエーション
  belongs_to :user
  belongs_to :post
  
  # 通知モデルとのアソシエーション
  has_many :notifications, dependent: :destroy
end
