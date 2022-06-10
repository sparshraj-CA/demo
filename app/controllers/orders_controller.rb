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
            
            @order = Order.new(cid: @customer.cid, pid: @item.pid, qty: @qty, bill: @tot, item_id: params[:itemid], customer_id: params[:cid]  )
            #binding.pry
            if @order.save
                render "/orders/success" 
            else
                @msg = "invalid order details."
                render "/orders/fail"
            end
        else
            @msg = "insufficient wallet balance."
            render "/orders/fail"
        end        
    end

    # def new
    #     @order = Item.new
    #   end
    
    #   def create
    #     @order = Item.new(cid: params[:cid], pid: params[:pid], qty: params[:qty], bill: params[:tot])
    
    #     if @order.save
    #       redirect_to @order
    #     else
    #       render :new, status: :unprocessable_entity
    #     end
    #   end

    private
    def order_params
      params.require(:order).permit(:cid, :pid, :qty, :bill)
    end
end
