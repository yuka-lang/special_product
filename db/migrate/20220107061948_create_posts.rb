class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :introduction
      t.text :word
      t.string :profile_image_url
      t.string :prefectures
      t.string :season
      t.string :post_content
      t.references :user

      t.timestamps
    end
  end
end
