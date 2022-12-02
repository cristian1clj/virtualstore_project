class ProductsController < ApplicationController
    def index
        @categories = Category.all
        @products = Product.all.with_attached_photo

        if params[:category_id]
            @products = @products.where(category_id: params[:category_id])
        end

        if params[:min_price].present?
            @products = @products.where("price >= ?", params[:min_price])
        end
        if params[:max_price].present?
            @products = @products.where("price <= ?", params[:max_price])
        end
        if params[:order_by].present?
            order_by = {
                newest: "created_at desc", 
                expesive: "price desc", 
                cheapest: "price asc"
            }.fetch(params[:order_by].to_sym)

            @products = @products.order(order_by)
        end
    end

    def details
        product
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: 'Tu producto de ha creado correctamente'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        product
    end

    def update
        if product.update(product_params)
            redirect_to products_path, notice: 'Tu producto se ha actualizado'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        product.destroy
        redirect_to products_path, notice: 'Tu producto se ha eliminado correctamente', status: :see_other
    end

    private

    def product_params
        params.require(:product).permit(:name, :description, :price, :photo, :category_id)
    end

    def product
        @product = Product.find(params[:id])
    end
end