class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|

      t.integer :post_id
      t.integer :visiter_id #通知を送ったユーザーID
      t.integer :visited_id #通知を送られたユーザーID
      t.integer :comment_id
      t.string :action #通知の種類(フォロー。いいね、コメント)
      t.boolean :checked, default: false, null: false #通知を送られたユーザーが確認をしたかどうか
      t.timestamps

    end
  end
end
