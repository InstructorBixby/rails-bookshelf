class GoalsController < ApplicationController
  before_action :require_login

  def create
    goal = current_user.goals.find_or_initialize_by(year: Date.today.year)
    goal.target = params[:target]
    if goal.save
      redirect_to stats_path, notice: 'Goal set.'
    else
      redirect_to stats_path, alert: goal.errors.full_messages.join(', ')
    end
  end
end
