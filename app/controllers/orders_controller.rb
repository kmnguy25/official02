class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    #@orders = Order.all
    #@orders = policy_scope(Order)
    @pagy, @orders = pagy(policy_scope(Order.order(date: :desc)))
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = policy_scope(Order).find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
    authorize @order
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    authorize @order
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      authorize @order
    end

    # Only allow a list of trusted parameters through.
    def order_params
      # params.require(:order).permit(:date, :lotstock, :quantity, :price, :total, :orderstatus_id, :picture_id)
      params.require(:order).permit(:ordernum, :date, :customer_id, :lotstock, :quantity, :price, :total, :orderstatus_id, cars_attributes: [:id, :vinnumber, :year, :make, :model, :titlestatus_id, :keystatus_id ,:destroy_],
      orderinvoices_attributes: [:id, :order_id, :invoice_id, :_destroy])
    end
end
