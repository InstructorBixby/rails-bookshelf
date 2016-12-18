class Goal < ApplicationRecord
  belongs_to :user

  validates :year, presence: true
  validates :target, numericality: { only_integer: true, greater_than: 0 }

  def self.current_for(user)
    return nil if user.nil?
    user.goals.find_by(year: Date.today.year)
  end

  def finished
    user.books.read
        .where('finished_on >= ? AND finished_on <= ?',
               Date.new(year, 1, 1), Date.new(year, 12, 31))
        .count
  end

  def percent
    return 0 if target.to_i.zero?
    [(finished * 100 / target), 100].min
  end
end
