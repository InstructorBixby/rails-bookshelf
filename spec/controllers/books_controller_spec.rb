require 'rails_helper'

describe BooksController do
  describe 'GET index' do
    it 'assigns every book' do
      b = create(:book)
      get :index
      expect(assigns(:books)).to eq([b])
    end

    it 'filters by status' do
      read = create(:book, status: 'read')
      create(:book, status: 'unread')
      get :index, status: 'read'
      expect(assigns(:books)).to eq([read])
    end

    it 'searches the author' do
      hit = create(:book, author: 'Ursula K. Le Guin')
      create(:book, author: 'Someone Else')
      get :index, q: 'Le Guin'
      expect(assigns(:books)).to eq([hit])
    end
  end

  describe 'POST create' do
    it 'saves a valid book' do
      expect {
        post :create, book: { title: 'Dune', author: 'Herbert', pages: 412 }
      }.to change(Book, :count).by(1)
    end

    it 'does not save an invalid one' do
      expect {
        post :create, book: { title: '', author: '' }
      }.not_to change(Book, :count)
    end

    it 're-renders new when invalid' do
      post :create, book: { title: '', author: '' }
      expect(response).to render_template('new')
    end
  end

  describe 'DELETE destroy' do
    it 'removes the book' do
      b = create(:book)
      expect { delete :destroy, id: b.id }.to change(Book, :count).by(-1)
    end
  end
end
