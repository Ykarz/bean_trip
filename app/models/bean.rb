class Bean < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :area, length: { maximum: 255 }
  validates :farm, length: { maximum: 255 }
  validates :comment, presence: true, length: { maximum: 65_535 }

  # 'roast_level'と'is_blended'カラムにenumを設定し、かつ範囲外の値を保存できないようにバリデーションを設定
  enum :roast_level, { not_selected: 0, light_roast: 1, medium_roast: 2, dark_roast: 3 }, validate: true
  enum :is_blended, { blend: true, straight: false }, validate: true

  belongs_to :user
  belongs_to :country
  # Storeモデルに関連付いたカラムは空値を許容したいので、'optional: true'とする
  belongs_to :store, optional: true

  # imageカラムにCarrierWaveの'BeanImageUploader'をマウント
  mount_uploader :image, BeanImageUploader
end
