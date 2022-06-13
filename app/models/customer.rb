class Customer < ApplicationRecord
    validates :cid, presence: true, uniqueness: true, format: { with:  /^C\d{3}$/, :multiline => true, message: "asks to follow this example format only: C101" }
    validates :wallet, presence: true, comparison: {greater_than: 0, less_than: 100000}

    #has_many :items, through {:orders, :wishlists}, disable_joins: true
    def items
        Item.joins([{orders: :itemid}, {wishlist: :itemid}])
               .where(users: {id: self.id})
      end

end
