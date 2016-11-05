require 'rails_helper'

describe Note do
  it 'needs a body' do
    expect(build(:note, body: '')).not_to be_valid
  end

  it 'is fine without a page number' do
    expect(build(:note, page: nil)).to be_valid
  end

  it 'comes back in page order' do
    book = create(:book)
    b = create(:note, book: book, page: 200)
    a = create(:note, book: book, page: 12)
    expect(book.notes.to_a).to eq([a, b])
  end

  it 'goes away with the book' do
    book = create(:book)
    create(:note, book: book)
    expect { book.destroy }.to change(Note, :count).by(-1)
  end
end
