json.books @books do |book|
  json.id book.id
  json.title book.title
  json.author book.author
  json.pages book.pages
  json.status book.status
  json.rating book.rating
  json.finished_on book.finished_on
  json.tags book.tags.map(&:name)
end
json.page @books.current_page
json.total @books.total_entries
