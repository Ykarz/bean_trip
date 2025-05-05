class CreateBeans < ActiveRecord::Migration[7.2]
  def change
    create_table :beans do |t|
      t.string :name, null: false
      t.string :area
      t.string :farm
      t.integer :roast_level
      t.boolean :blended
      t.integer :bitterness
      t.integer :sweetness
      t.integer :acidity
      t.integer :body
      t.integer :aroma
      t.string :image
      t.text :comment, null: false
      t.references :user, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
