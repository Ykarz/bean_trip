class CreateBeanBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bean_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bean, null: false, foreign_key: true

      t.timestamps
    end
    # ユーザーが同じ豆投稿を複数回ブックマークできないように、一意制約を追加
    add_index :bean_bookmarks, [:user_id, :bean_id], unique: true
  end
end
