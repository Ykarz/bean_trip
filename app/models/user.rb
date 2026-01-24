class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # nameカラムに対するバリデーション：空の値を許容しない、最小4文字、最大30文字
  validates :name, presence: true, length: { minimum: 4, maximum: 30 }

  has_many :beans, dependent: :destroy

  # BeanBookmarkモデルとの多対多の関連付け
  has_many :bean_bookmarks, dependent: :destroy
  # BeanBookmarkモデルを介して、ユーザーがブックマークした豆投稿を取得
  has_many :bookmarked_beans, through: :bean_bookmarks, source: :bean

  # StoreBookmarkモデルとの多対多の関連付け
  has_many :store_bookmarks, dependent: :destroy
  # StoreBookmarkモデルを介して、ユーザーがブックマークした店舗を取得
  has_many :bookmarked_stores, through: :store_bookmarks, source: :store

  # avatarカラムにCarrierWaveの'AvatarImageUploader'をマウント
  mount_uploader :avatar, AvatarImageUploader

  # メソッドの呼び出し元である、Userモデルのインスタンスの'id'カラムの値と、
  # 引数に渡された'object'に紐付けられているusersテーブルのレコードの'id'カラムの値が等しければ'ture'を返す
  def own?(object)
    id == object&.user_id
  end

  # ユーザーが豆投稿をブックマークに追加するメソッド
  def bookmark_bean(bean)
    bookmarked_beans << bean
  end

  # ユーザーが豆投稿のブックマークを解除するメソッド
  def unbookmark_bean(bean)
    bookmarked_beans.destroy(bean)
  end

  # ユーザーが特定の豆投稿をブックマークしているかどうかを確認するメソッド
  def bean_bookmarked?(bean)
    bookmarked_beans.include?(bean)
  end

  # ユーザーが店舗をブックマークに追加するメソッド
  def bookmark_store(store)
    bookmarked_stores << store
  end

  # ユーザーが店舗のブックマークを解除するメソッド
  def unbookmark_store(store)
    bookmarked_stores.destroy(store)
  end

  # ユーザーが特定の店舗をブックマークしているかどうかを確認するメソッド
  def store_bookmarked?(store)
    bookmarked_stores.include?(store)
  end
end
