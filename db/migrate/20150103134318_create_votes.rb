class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.integer :voteable_id, index: true
      t.string :voteable_type
      t.timestamps
    end
  end
end
