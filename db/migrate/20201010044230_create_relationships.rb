class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|

      t.integer :follower_id　#フォローするユーザーID
      t.integer :followed_id　#フォローされるユーザーID
      t.timestamps

    end
  end
end
