class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.string :content
      t.text :tag_content
      t.string :image_id
      t.timestamps

    end
  end
end
