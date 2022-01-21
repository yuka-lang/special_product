class Comment < ApplicationRecord
  # コメント機能のアソシエーション
  belongs_to :user
  belongs_to :post
end
