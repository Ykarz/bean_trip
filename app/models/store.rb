class Store < ApplicationRecord
  validates :place_id, :name, :latitude, :longitude, presence: true, uniqueness: true

  has_many :beans

  # Ransackが検索可能なカラムを設定
  def self.ransackable_attributes(auth_object = nil)
    ["name", "address"]
  end
end
