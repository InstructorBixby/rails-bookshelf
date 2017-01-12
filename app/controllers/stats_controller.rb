class StatsController < ApplicationController
  def index
    read = Book.read.where.not(finished_on: nil)
    @total = read.count
    @pages = read.sum(:pages)
    @by_month = Book.finished_per_month(12)
    @by_rating = Book.where.not(rating: nil).group(:rating).count
    @goal = Goal.current_for(current_user)
  end
end
