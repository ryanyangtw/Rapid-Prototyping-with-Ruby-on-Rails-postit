class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.integer :post_id , index: true
      t.integer :category_id, index: true
      t.timestamps
    end
  end
end
