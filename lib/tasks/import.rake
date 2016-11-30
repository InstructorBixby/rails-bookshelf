require 'csv'

namespace :books do
  desc 'import a goodreads csv export: rails books:import FILE=x.csv'
  task import: :environment do
    file = ENV['FILE']
    raise 'FILE=' if file.nil?
    user = User.order(:id).first

    n = 0
    skipped = 0
    CSV.foreach(file, headers: true) do |row|
      status = case row['Exclusive Shelf']
               when 'read' then 'read'
               when 'currently-reading' then 'reading'
               else 'unread'
               end

      # things the export does that i did not expect:
      #  - ISBN13 comes out as ="9780441013593" so excel wont mangle it
      #  - My Rating is 0 for "not rated", and 0 fails my validation
      #  - Date Read is blank for a lot of read books
      #  - Number of Pages is blank for ebooks
      rating = row['My Rating'].to_i
      rating = nil if rating.zero?

      pages = row['Number of Pages'].to_s.strip
      pages = nil if pages.empty?

      date = row['Date Read'].to_s.strip
      date = nil if date.empty?

      book = user.books.new(
        title: row['Title'],
        author: row['Author'],
        isbn: row['ISBN13'].to_s.gsub(/[^0-9]/, ''),
        pages: pages,
        status: status,
        rating: rating,
        finished_on: date
      )

      shelves = row['Bookshelves'].to_s
      book.tag_list = shelves.tr(' ', ',') unless shelves.empty?

      if book.save
        n += 1
      else
        skipped += 1
        puts "skipped #{row['Title']}: #{book.errors.full_messages.join(', ')}"
      end
    end
    puts "imported #{n}, skipped #{skipped}"
  end
end
