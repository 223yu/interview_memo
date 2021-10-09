class CreateFollowTags < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_tags do |t|
      t.integer :user_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
  end
end
