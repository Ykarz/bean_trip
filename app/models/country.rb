class Country < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  has_many :beans

  # Ransackが検索可能なカラムを設定
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
