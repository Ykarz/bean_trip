class StoreBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :store

  # 'user_id'と'store_id'の組み合わせが一意であることを保証するバリデーション
  validates :user_id, uniqueness: { scope: :store_id }
end
