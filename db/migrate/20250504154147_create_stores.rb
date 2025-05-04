class CreateStores < ActiveRecord::Migration[7.2]
  def change
    create_table :stores do |t|
      t.string :place_id, null: false
      t.string :name, null: false
      t.string :post_code
      t.string :address
      t.string :phone_number
      t.string :opening_hours
      t.string :web_site_url
      t.decimal :rating
      t.string :image
      t.decimal :latitude, precision: 10, scale: 7, null: false
      t.decimal :longitude, precision: 10, scale: 7, null: false

      t.timestamps
    end
  end
end
