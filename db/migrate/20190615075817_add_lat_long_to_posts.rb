class AddLatLongToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :lat, :string
    add_column :posts, :long, :string
  end
end
