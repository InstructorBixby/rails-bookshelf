# bin/rails db:seed
# a handful of books off my shelf so the list is not empty

me = User.find_or_create_by!(email: 'me@example.com') do |u|
  u.name = 'Me'
  u.password = 'changeme'
end

me.books.destroy_all

[
  ['The Dispossessed', 'Ursula K. Le Guin', 341, 'read', 5],
  ['Dune', 'Frank Herbert', 412, 'read', 4],
  ['Structure and Interpretation of Computer Programs',
   'Abelson and Sussman', 657, 'reading', nil],
  ['The Mythical Man-Month', 'Fred Brooks', 322, 'read', 4],
  ['Godel, Escher, Bach', 'Douglas Hofstadter', 777, 'unread', nil],
  ['Snow Crash', 'Neal Stephenson', 440, 'read', 4],
  ['The Soul of a New Machine', 'Tracy Kidder', 293, 'unread', nil]
].each do |title, author, pages, status, rating|
  me.books.create!(title: title, author: author, pages: pages,
                   status: status, rating: rating,
                   finished_on: status == 'read' ? Date.today - rand(400) : nil)
end

puts "#{Book.count} books"
