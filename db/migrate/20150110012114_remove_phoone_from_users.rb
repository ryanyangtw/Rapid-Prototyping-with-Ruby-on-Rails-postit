class RemovePhooneFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :phoone, :string
  end
end
