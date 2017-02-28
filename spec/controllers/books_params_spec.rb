require 'rails_helper'

# noticed this reading the strong parameters guide: user_id was never
# in permit() so this already worked, but i wanted a test that fails
# if someone adds it to the list later.
describe BooksController do
  it 'ignores a user_id in the form' do
    me = create(:user)
    someone_else = create(:user)
    log_in_as(me)

    post :create, params: { book: { title: 'Mine', author: 'Me',
                                    user_id: someone_else.id } }

    expect(Book.last.user).to eq(me)
  end
end
