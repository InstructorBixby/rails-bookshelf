namespace :books do
  desc 'delete duplicate books with the same isbn, keep the oldest'
  task dedupe: :environment do
    groups = Book.where.not(isbn: [nil, '']).group_by(&:isbn)
    killed = 0
    groups.each do |isbn, books|
      next if books.length < 2
      books.sort_by(&:id).drop(1).each do |b|
        puts "removing #{b.id} #{b.title}"
        b.destroy rescue nil
        killed += 1
      end
    end
    puts "removed #{killed}"
  end
end
