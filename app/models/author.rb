class Author < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_votes, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w\-\.]+@\w+\.\w+\z/i
  VALID_PASSWORD_REGEX = /\A[A-Za-z0-9\-\+_]{8,20}\z/

  validates :email, :first_name, :last_name, :gender, :birthday, presence: true
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true

  before_save :downcase_email

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private
  def downcase_email
    self.email.downcase!
  end
end
