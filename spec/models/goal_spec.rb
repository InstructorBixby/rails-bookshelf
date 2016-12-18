require 'rails_helper'

describe Goal do
  let(:user) { create(:user) }

  it 'needs a positive target' do
    expect(build(:goal, user: user, target: 0)).not_to be_valid
  end

  it 'counts only books finished in its own year' do
    goal = create(:goal, user: user, year: Date.today.year, target: 10)
    create(:book, user: user, status: 'read', finished_on: Date.today)
    create(:book, user: user, status: 'read',
                  finished_on: Date.new(Date.today.year - 2, 6, 1))
    expect(goal.finished).to eq(1)
  end

  it 'caps the percentage at 100' do
    goal = create(:goal, user: user, year: Date.today.year, target: 1)
    3.times { create(:book, user: user, status: 'read', finished_on: Date.today) }
    expect(goal.percent).to eq(100)
  end
end
