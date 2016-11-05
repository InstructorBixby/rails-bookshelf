class Book < ApplicationRecord
  STATUSES = %w(unread reading read)

  belongs_to :user
  has_many :notes, dependent: :destroy
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

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

  # the form gives me "scifi, politics, reread" in one text field
  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(value)
    names = value.to_s.split(',').map { |n| n.downcase.strip }
    names.reject!(&:empty?)
    self.tags = names.uniq.map { |n| Tag.find_or_create_by(name: n) }
  end

  def stars
    return '' if rating.nil?
    '*' * rating
  end
end
