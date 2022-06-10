class Item < ApplicationRecord  #/^A\d{3}$/
    validates :pid, presence: true,  uniqueness: true, format: { with:  /^P\d{3}$/, :multiline => true, message: "asks to follow this example format only: P101" }
    validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters." } 
    validates :qty, presence: true, comparison: {greater_than: 0}, numericality: { only_integer: true }
    validates :price, presence: true, comparison: {greater_than: 0}, numericality: { only_float: true }

    has_many :customers, through :orders
end
