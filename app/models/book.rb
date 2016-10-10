class Book < ActiveRecord::Base
  STATUSES = %w(unread reading read)

  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true
  validates :pages, numericality: { only_integer: true,
                                    greater_than: 0,
                                    allow_nil: true }
  validates :status, inclusion: { in: STATUSES }
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true

  scope :unread, -> { where(status: 'unread') }
  scope :reading, -> { where(status: 'reading') }
  scope :read, -> { where(status: 'read') }

  scope :search, lambda { |q|
    where('title LIKE ? OR author LIKE ?', "%#{q}%", "%#{q}%")
  }

  def stars
    return '' if rating.nil?
    '*' * rating
  end
end
