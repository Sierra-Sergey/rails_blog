class Author < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
