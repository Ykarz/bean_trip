class CreateBeanBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bean_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bean, null: false, foreign_key: true

      t.timestamps
    end
  end
end
