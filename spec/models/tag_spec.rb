require 'rails_helper'

describe Tag do
  it 'downcases the name' do
    expect(Tag.create!(name: 'SciFi').name).to eq('scifi')
  end

  it 'will not take the same name twice' do
    Tag.create!(name: 'scifi')
    expect(Tag.new(name: 'scifi')).not_to be_valid
  end
end

describe 'tagging a book' do
  it 'takes a comma separated list' do
    b = create(:book)
    b.tag_list = 'scifi, Politics , scifi'
    b.save!
    expect(b.reload.tags.map(&:name).sort).to eq(%w(politics scifi))
  end

  it 'reads back as a string' do
    b = create(:book)
    b.tag_list = 'a, b'
    b.save!
    expect(b.reload.tag_list).to eq('a, b')
  end
end
