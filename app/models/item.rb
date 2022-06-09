class Item < ApplicationRecord
    validates :pid, presence: true, uniqueness: true
    validates :name, presence: true
    validates :qty, presence: true, comparison: {greater_than: 0}
    validates :price, presence: true, comparison: {greater_than: 0}

    has_and_belongs_to_many :customers
end
