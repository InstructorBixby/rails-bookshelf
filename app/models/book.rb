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

  # pulling every read book into memory to count them by month was fine
  # with 80 books and will not be fine later. sqlite has strftime and
  # postgres has to_char, so pick one at runtime off the adapter.
  def self.month_expression
    if connection.adapter_name =~ /sqlite/i
      "strftime('%Y-%m', finished_on)"
    else
      "to_char(finished_on, 'YYYY-MM')"
    end
  end

  def self.finished_per_month(limit = 12)
    read.where.not(finished_on: nil)
        .group(month_expression)
        .order("1 desc")
        .limit(limit)
        .count
        .sort
  end

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
