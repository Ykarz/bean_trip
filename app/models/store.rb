class Store < ApplicationRecord
  # 'place_id'：Google Mapsにおいて、特定の場所を一意に識別するためのID
  # このため、空の値を許容しないことと、一意であることをバリデーションで保証
  validates :place_id, presence: true, uniqueness: true
  validates :name, :latitude, :longitude, presence: true

  has_many :beans

  # StoreBookmarkモデルとの1対多の関連付け
  has_many :store_bookmarks, dependent: :destroy

  # Ransackが検索可能なカラムを設定
  def self.ransackable_attributes(auth_object = nil)
    ["name", "address"]
  end

  # Ransackが検索可能なアソシエーションを設定
  def self.ransackable_associations(auth_object = nil)
    ["beans"]
  end
end
