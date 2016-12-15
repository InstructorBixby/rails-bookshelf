require 'rails_helper'

describe 'Book.finished_per_month' do
  it 'counts the books in each month' do
    d = Date.today.beginning_of_month
    create(:book, status: 'read', finished_on: d)
    create(:book, status: 'read', finished_on: d + 2)
    create(:book, status: 'read', finished_on: d - 40)

    out = Book.finished_per_month(12)
    expect(out.last[1]).to eq(2)
  end

  it 'ignores books with no finished date' do
    create(:book, status: 'read', finished_on: nil)
    expect(Book.finished_per_month(12)).to eq([])
  end
end
