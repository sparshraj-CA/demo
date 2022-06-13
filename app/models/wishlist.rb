class Wishlist < ApplicationRecord
  validates :item_id, presence: true, uniqueness: true
  belongs_to :item
  belongs_to :customer
end
