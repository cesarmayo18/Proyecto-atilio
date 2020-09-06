class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :confirmation]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(status:"creada") if current_user.profile.repartidor?
    @orders = Order.where(cliente_id:current_user.profile.id) if current_user.profile.cliente?
    @prod = Product.where(profile_id: current_user.profile.id) if current_user.profile.tienda?
    @orders = [] if current_user.profile.tienda?
    puts @prod
    @prod.each do |p|
      Order.where(product_id: p.id).each do |o|
      @orders.push(o)
      puts @orders
      puts '----'
      end
    end if current_user.profile.tienda?
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def entregar
    @user= current_user.profile
    @user.balance = @user.balance.to_i + 200;
    @order = Order.find(params["id"])
    @producto = Product.find(@order.product_id)
    @tienda = @producto.profile
    @tienda.balance = @tienda.balance.to_i + @producto.price
    @order.entregada!
    redirect_to repartidor_dashboard_path, notice: "Orden entregada" if @order.save && @user.save && @tienda.save

  end

  def dashboard
    @clima =  Profile.clima();
    @icon ="#{@clima["current"]["condition"]["icon"].slice!(@clima["current"]["condition"]["icon"].length-7..@clima["current"]["condition"]["icon"].length)}"
    @orders = Order.where(repartidor_id: current_user.profile.id)
  end

  def confirmation
    @order = Order.find(params["id"])
    @order.repartidor_id = current_user.profile.id
    @order.camino!
    redirect_to repartidor_dashboard_path, notice: "Orden TOMADA" if @order.save
  end

  def buy
    prod=Product.find(params["id"])
    @profile = current_user.profile
    if @profile.balance > prod.price then
      puts @profile.balance
      puts prod.price
      @profile.balance = @profile.balance - prod.price
      @profile.save
      @order = Order.new(cliente_id: current_user.profile.id, repartidor_id: current_user.profile.id, status: 0,
                   product_id: prod.id)

      redirect_to products_path, notice: "Orden Creada" if @order.save
    else
      redirect_to products_path, notice: "Saldo insuficiente"
    end
  end

  # GET /orders/new
  def new
    redirect_to root_path if current_user.profile.repartidor? || current_user.profile.tienda
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    redirect_to root_path if current_user.profile.tienda
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.repartidor = current_user.profile
    @order.cliente = current_user.profile

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
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:profile_id, :status, :product_id, :profile_id)
    end
end
