require 'rails_helper'
require 'rake'

describe 'books:import' do
  before(:all) do
    Rake.application.rake_require('tasks/import')
    Rake::Task.define_task(:environment)
  end

  let(:csv) do
    path = Rails.root.join('tmp', 'import_spec.csv')
    File.open(path, 'w') do |f|
      f.puts 'Title,Author,ISBN13,Number of Pages,Exclusive Shelf,My Rating,Date Read,Bookshelves'
      f.puts 'Dune,Frank Herbert,="9780441013593",412,read,4,2015/01/02,scifi'
      f.puts 'Ebook With No Pages,Someone,"",,to-read,0,,'
    end
    path.to_s
  end

  it 'imports both rows' do
    create(:user)
    ENV['FILE'] = csv
    expect { Rake::Task['books:import'].invoke }.to change(Book, :count).by(2)
  end
end
