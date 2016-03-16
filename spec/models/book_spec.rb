require 'rails_helper'

describe Book do
  it 'needs a title' do
    b = Book.new(author: 'Someone')
    expect(b).not_to be_valid
  end

  it 'needs an author' do
    b = Book.new(title: 'Something')
    expect(b).not_to be_valid
  end

  it 'is valid with both' do
    b = Book.new(title: 'Something', author: 'Someone')
    expect(b).to be_valid
  end

  it 'rejects negative pages' do
    b = Book.new(title: 'a', author: 'b', pages: -4)
    expect(b).not_to be_valid
  end
end
