class CreateCommentVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_votes do |t|
      t.references :author, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.integer :vote_value

      t.timestamps
    end
  end
end
