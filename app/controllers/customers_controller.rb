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

  private
    def customer_params
      params.require(:customer).permit(:cid, :wallet)
    end
end
