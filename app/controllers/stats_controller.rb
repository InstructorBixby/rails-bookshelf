class StatsController < ApplicationController
  def index
    read = Book.read.where.not(finished_on: nil)
    @total = read.count
    @pages = read.sum(:pages)

    # group by month in ruby because sqlite and postgres disagree about
    # how to format a date and i want this to work in both
    @by_month = {}
    read.each do |b|
      key = b.finished_on.strftime('%Y-%m')
      @by_month[key] = (@by_month[key] || 0) + 1
    end
    @by_month = @by_month.sort.last(12)

    @by_rating = Book.where.not(rating: nil).group(:rating).count
  end
end
