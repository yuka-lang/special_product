class Chat < ApplicationRecord
  # DM機能のアソシエーション
  belongs_to :user
  belongs_to :room, optional: true
end
