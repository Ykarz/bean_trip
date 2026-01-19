class CreateStoreBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :store_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
