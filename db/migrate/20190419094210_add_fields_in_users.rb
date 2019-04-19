class AddFieldsInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :text
    add_column :users, :profile_image, :string
  end
end
