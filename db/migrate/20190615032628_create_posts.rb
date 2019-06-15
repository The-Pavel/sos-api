class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :description
      t.integer :capacity
      t.string :location
      t.string :contact_number
      t.boolean :is_full
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
