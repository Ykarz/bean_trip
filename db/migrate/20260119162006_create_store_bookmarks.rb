class CreateStoreBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :store_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
    # ユーザーが同じ店舗を複数回ブックマークできないようにするための一意制約
    add_index :store_bookmarks, [:user_id, :store_id], unique: true
  end
end
