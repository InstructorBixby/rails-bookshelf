require 'net/http'
require 'json'

# https://openlibrary.org/dev/docs/api/books
# GET /api/books?bibkeys=ISBN:9780441013593&format=json&jscmd=data
#
# no api key needed which is why i picked it over the google one
class OpenLibrary
  URL = 'https://openlibrary.org/api/books'

  def self.lookup(isbn)
    isbn = isbn.to_s.gsub(/[^0-9Xx]/, '')
    return nil if isbn.empty?

    uri = URI(URL)
    uri.query = URI.encode_www_form('bibkeys' => "ISBN:#{isbn}",
                                    'format' => 'json',
                                    'jscmd' => 'data')
    body = Net::HTTP.get(uri)
    data = JSON.parse(body)
    entry = data["ISBN:#{isbn}"]
    return nil if entry.nil?

    authors = entry['authors'] || []
    cover = entry['cover'] || {}

    { title: entry['title'],
      author: authors.map { |a| a['name'] }.join(', '),
      pages: entry['number_of_pages'],
      cover_url: cover['medium'] }
  rescue JSON::ParserError, SocketError => e
    Rails.logger.warn("open library lookup failed: #{e.message}")
    nil
  end
end
