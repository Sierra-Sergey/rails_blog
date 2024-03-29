class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :image
      t.references :author
      t.integer :comments_count
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
