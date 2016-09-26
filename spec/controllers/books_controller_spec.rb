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

  describe 'when nobody is logged in' do
    it 'will not show the new form' do
      get :new
      expect(response).to redirect_to(login_path)
    end

    it 'will not create' do
      expect {
        post :create, book: { title: 'Dune', author: 'Herbert' }
      }.not_to change(Book, :count)
    end
  end

  describe 'logged in' do
    before(:each) { log_in_as(create(:user)) }

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

    it 'removes the book' do
      b = create(:book)
      expect { delete :destroy, id: b.id }.to change(Book, :count).by(-1)
    end
  end
end
