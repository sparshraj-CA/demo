class CustomersController < ApplicationController

  http_basic_authenticate_with name: "cust", password: "cust", except: [:index, :show]
  def index
    @customers=Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to "/customers/"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @orders = Order.where(cid: @customer.cid)
  end

  def wishlist
    @item = Item.find(params[:itemid])
    @customer = Customer.find(params[:cid])

    @wish = Wishlist.new(item_id: @item.id, customer_id: @customer.id)
    #binding.pry
    if @wish.save
      @wish=Wishlist.where(customer_id: params[:cid])
      @items=[]
      @wish.each  {  |wish| @items.append(Item.find(wish.item_id)) }
      render "/customers/wishlist"
    else
      redirect_to "/items"
    end
  end

  def viewwishlist
    @customer = Customer.find(params[:cid])
    @wish=Wishlist.where(customer_id: params[:cid])
    #binding.pry

    @items=[]
    @wish.each  {  |wish| @items.append(Item.find(wish.item_id)) }
    # @items=Item.where(pid: @wish.item_id)
    render "/customers/wishlist"
  end


  def delwishlist
    @customer = Wishlist.find_by_customer_id(params[:cid])
    @customer.delete
  #   @customer.each {|customer| 
  #   if (customer.item_id==params[:itemid]) 
  #     customer.delete 
  #   end
  # }
    #render "/customers/wishlist"

    viewwishlist
  end

  private
    def customer_params
      params.require(:customer).permit(:cid, :wallet)
    end
end
