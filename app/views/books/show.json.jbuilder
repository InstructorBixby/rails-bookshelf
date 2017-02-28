json.id @book.id
json.title @book.title
json.author @book.author
json.isbn @book.isbn
json.pages @book.pages
json.status @book.status
json.rating @book.rating
json.finished_on @book.finished_on
json.cover_url @book.cover_url
json.tags @book.tags.map(&:name)
json.notes @book.notes do |note|
  json.page note.page
  json.body note.body
end
