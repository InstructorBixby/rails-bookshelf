require 'rails_helper'

describe 'Book.to_csv' do
  it 'has a header row and one row per book' do
    create(:book, title: 'Dune', author: 'Frank Herbert')
    out = Book.to_csv(Book.all)
    lines = out.split("\n")
    expect(lines.length).to eq(2)
    expect(lines[0]).to start_with('title,author,isbn')
    expect(lines[1]).to include('Dune')
  end
end
