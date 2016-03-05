class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :author, presence: true
  validates :pages, numericality: { only_integer: true,
                                    greater_than: 0,
                                    allow_nil: true }
end
