class BooksController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  PER_PAGE = 25

  def index
    @status = params[:status]
    @q = params[:q]
    @tag = params[:tag]
    # includes(:tags) turns 25 little tag queries into one. the log
    # went from 30 lines per page load to 4.
    books = Book.includes(:tags).order('title')
    books = books.where(status: @status) if Book::STATUSES.include?(@status)
    books = books.search(@q) if @q.present?
    books = books.joins(:tags).where(tags: { name: @tag }) if @tag.present?
    @books = books.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def show
  end

  def new
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.new(book_params)
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
                                 :rating, :finished_on, :tag_list)
  end
end
