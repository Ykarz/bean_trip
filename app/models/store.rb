class Store < ApplicationRecord
  validates :place_id, :name, :latitude, :longitude, presence: true, uniqueness: true

  has_many :beans
end
