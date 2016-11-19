require 'csv'

namespace :books do
  desc 'import a goodreads csv export: rails books:import FILE=x.csv'
  task import: :environment do
    file = ENV['FILE']
    raise 'FILE=' if file.nil?
    user = User.order(:id).first

    n = 0
    CSV.foreach(file, headers: true) do |row|
      status = case row['Exclusive Shelf']
               when 'read' then 'read'
               when 'currently-reading' then 'reading'
               else 'unread'
               end

      book = user.books.new(
        title: row['Title'],
        author: row['Author'],
        isbn: row['ISBN13'].to_s.gsub(/[^0-9]/, ''),
        pages: row['Number of Pages'],
        status: status,
        rating: row['My Rating'].to_i,
        finished_on: row['Date Read']
      )
      if book.save
        n += 1
      else
        puts "skipped #{row['Title']}: #{book.errors.full_messages.join(', ')}"
      end
    end
    puts "imported #{n}"
  end
end
