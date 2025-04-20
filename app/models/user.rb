class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # nameカラムに対するバリデーション：空の値を許容しない、最小4文字、最大30文字
  validates :name, presence: true, length: { minimum: 4, maximum: 30 }
end
