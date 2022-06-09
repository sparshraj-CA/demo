class OrdersController < ApplicationController
    def index
        @items=Item.all
        @customer=Customer.find_by_cid(params[:cid])
    end

    def buy
        @item=Item.find(params[:itemid])
        @customer=Customer.find(params[:cid])
        @message = nil
    end

    def placeorder
        @item = Item.find(params[:itemid])
        @customer = Customer.find(params[:cid])
        
        # binding.pry
        param! :qty,  Integer, required: true, min: 1, max: @item.qty , message: "Please provide a valid quantity input between 1 to the item_available_qty (inclusive)."      
        @qty = params[:qty].to_i

        @tot = @item.price * @qty
        @tot=@tot.round
        if(@tot<=@customer.wallet)
            @item.qty -= @qty
            @item.save
            @customer.wallet-=@tot
            @customer.wallet=@customer.wallet.round
            @customer.save
            # binding.pry
            render "/orders/success" 
        else
            render "/orders/fail"
        end        
    end

end
