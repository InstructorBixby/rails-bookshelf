require 'csv'

module Exportable
  extend ActiveSupport::Concern

  class_methods do
    COLUMNS = %w(title author isbn pages status rating finished_on).freeze

    def to_csv(scope = all)
      CSV.generate(headers: true) do |csv|
        csv << COLUMNS + ['tags']
        scope.each do |book|
          csv << COLUMNS.map { |c| book.send(c) } + [book.tag_list]
        end
      end
    end
  end
end
