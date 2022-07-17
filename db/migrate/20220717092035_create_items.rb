class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :flight_number
      t.string :image
      t.timestamps :departure_time
      t.integer :price
      t.boolean :reserved, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
