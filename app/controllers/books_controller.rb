class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render 'new'
    end
  end

  private

  # without this rails raises ForbiddenAttributesError, which took me
  # a while to understand. you have to say which fields the form is
  # allowed to set.
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :pages)
  end
end
