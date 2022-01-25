class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :birthday
      t.string :avatar
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
