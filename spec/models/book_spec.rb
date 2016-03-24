require 'rails_helper'

describe Book do
  it 'needs a title' do
    expect(build(:book, title: nil)).not_to be_valid
  end

  it 'needs an author' do
    expect(build(:book, author: nil)).not_to be_valid
  end

  it 'is valid with both' do
    expect(build(:book)).to be_valid
  end

  it 'rejects negative pages' do
    expect(build(:book, pages: -4)).not_to be_valid
  end
end
