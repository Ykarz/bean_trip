class Bean < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :area, length: { maximum: 255 }
  validates :farm, length: { maximum: 255 }
  validates :comment, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :country
  # Storeモデルに関連付いたカラムは空値を許容したいので、'optional: true'とする
  belongs_to :store, optional: true

  # imageカラムにCarrierWaveの'BeanImageUploader'をマウント
  mount_uploader :image, BeanImageUploader
end
