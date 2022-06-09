class ItemsController < ApplicationController

  http_basic_authenticate_with name: "seller", password: "seller", except: [:index, :show]
  def index
    # binding.pry
    @items=Item.all
    @msg=nil
  end

  def show
    @item=Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    param! :query, String, required: true, message: "Please provide valid product name!"
    @item=Item.find_by_name(params[:query])
    
    # binding.pry
    if @item == nil
      @items = Item.all
      @msg="Item not found!"
      render "/items/index"
    else
      redirect_to @item
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def item_params
      params.require(:item).permit(:pid, :name, :qty, :price)
    end
end
