class User < ApplicationRecord
  has_many :books, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  before_save { self.email = email.downcase }
end
