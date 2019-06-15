class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :address
      t.string :contact_number
      t.string :language

      t.timestamps
    end
  end
end
