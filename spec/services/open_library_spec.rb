require 'rails_helper'

describe OpenLibrary do
  it 'returns nil for an empty isbn' do
    expect(OpenLibrary.lookup('')).to be_nil
  end

  it 'pulls the fields out of a response' do
    body = {
      'ISBN:9780441013593' => {
        'title' => 'Dune',
        'authors' => [{ 'name' => 'Frank Herbert' }],
        'number_of_pages' => 412,
        'cover' => { 'medium' => 'http://covers.example/1-M.jpg' }
      }
    }.to_json
    allow(Net::HTTP).to receive(:get).and_return(body)

    out = OpenLibrary.lookup('978-0-441-01359-3')
    expect(out[:title]).to eq('Dune')
    expect(out[:author]).to eq('Frank Herbert')
    expect(out[:pages]).to eq(412)
  end
end
