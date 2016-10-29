class Note < ApplicationRecord
  belongs_to :book

  validates :body, presence: true
  validates :page, numericality: { only_integer: true, allow_nil: true }

  default_scope { order('page asc, id asc') }
end
