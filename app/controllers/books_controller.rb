class BooksController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  PER_PAGE = 25
  SORTS = { 'title' => 'title asc',
            'author' => 'author asc',
            'rating' => 'rating desc',
            'finished' => 'finished_on desc' }.freeze

  def index
    @status = params[:status]
    @q = params[:q]
    @tag = params[:tag]
    @sort = SORTS.key?(params[:sort]) ? params[:sort] : 'title'

    books = Book.includes(:tags).order(SORTS[@sort])
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

  def lookup
    @book = current_user.books.new(isbn: params[:isbn])
    found = OpenLibrary.lookup(params[:isbn])
    if found
      @book.title = found[:title]
      @book.author = found[:author]
      @book.pages = found[:pages]
      @book.cover_url = found[:cover_url]
    else
      flash.now[:alert] = 'Nothing found for that ISBN.'
    end
    render 'new'
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
                                 :rating, :finished_on, :tag_list,
                                 :cover_url)
  end
end
