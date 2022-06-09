class Customer < ApplicationRecord
    validates :cid, presence: true, uniqueness: true
    validates :wallet, presence: true, comparison: {greater_than: 0, less_than: 100000}

    has_and_belongs_to_many :items
end
