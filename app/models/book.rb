class Book < ActiveRecord::Base
  STATUSES = %w(unread reading read)

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

  def stars
    return '' if rating.nil?
    '*' * rating
  end
end
