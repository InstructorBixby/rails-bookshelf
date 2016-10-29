class NotesController < ApplicationController
  before_action :require_login

  def create
    @book = Book.find(params[:book_id])
    @note = @book.notes.new(note_params)
    if @note.save
      redirect_to @book, notice: 'Noted.'
    else
      redirect_to @book, alert: 'A note needs some text.'
    end
  end

  def destroy
    note = Note.find(params[:id])
    book = note.book
    note.destroy
    redirect_to book, notice: 'Deleted.'
  end

  private

  def note_params
    params.require(:note).permit(:body, :page)
  end
end
