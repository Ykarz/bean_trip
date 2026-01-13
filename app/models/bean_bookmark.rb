class BeanBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bean

  # 'user_id'と'bean_id'の組み合わせが一意であることを保証するバリデーション
  validates :user_id, uniqueness: { scope: :bean_id }
end
