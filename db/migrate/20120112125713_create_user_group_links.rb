class CreateUserGroupLinks < ActiveRecord::Migration
  def change
    create_table :user_group_links do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
