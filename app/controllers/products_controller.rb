class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all if current_user.profile.cliente?
    @products = Product.where(profile_id: current_user.profile.id) if current_user.profile.tienda?
    redirect_to root_path if current_user.profile.repartidor?
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    redirect_to root_path if current_user.profile.repartidor? || current_user.profile.cliente?
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    redirect_to root_path if current_user.profile.repartidor? || current_user.profile.cliente?
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.profile = current_user.profile
    puts @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:description, :name, :price, :rating, :category, :store_id, :products_pic, :profile)
    end
end
