class AddLanguageToPosts < ActiveRecord::Migration[5.2]
  def change
        add_column :posts, :language, :string
  end
end
