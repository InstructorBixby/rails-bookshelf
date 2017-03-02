require 'rails_helper'

describe 'the json' do
  it 'lists books' do
    create(:book, title: 'Dune', author: 'Frank Herbert')
    get '/books.json'

    expect(response).to be_success
    body = JSON.parse(response.body)
    expect(body['books'].length).to eq(1)
    expect(body['books'][0]['title']).to eq('Dune')
    expect(body['total']).to eq(1)
  end

  it 'includes the tags' do
    book = create(:book)
    book.tag_list = 'scifi'
    book.save!

    get "/books/#{book.id}.json"
    body = JSON.parse(response.body)
    expect(body['tags']).to eq(['scifi'])
  end

  it '404s a book that is not there' do
    get '/books/999999.json'
    expect(response.status).to eq(404)
  end
end
