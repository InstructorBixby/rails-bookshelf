class User < ActiveRecord::Base
  # has_secure_password gives you password / password_confirmation and
  # does the bcrypt part. it needs the column to be called
  # password_digest, which i found out the slow way.
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  before_save { self.email = email.downcase }
end
