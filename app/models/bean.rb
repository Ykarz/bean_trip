class Bean < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :area, length: { maximum: 255 }
  validates :farm, length: { maximum: 255 }
  validates :comment, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :country
  belongs_to :store
end
