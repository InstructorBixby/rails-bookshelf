class BooksController < ApplicationController
  before_filter :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @status = params[:status]
    @q = params[:q]
    @books = Book.all
    @books = @books.where(status: @status) if Book::STATUSES.include?(@status)
    @books = @books.search(@q) if @q.present?
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: 'Added.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Saved.'
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Gone.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :pages, :status,
                                 :rating, :finished_on)
  end
end
