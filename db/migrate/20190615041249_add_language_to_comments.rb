class AddLanguageToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :language, :string
  end
end
