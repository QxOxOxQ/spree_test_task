# frozen_string_literal: true

class Spree::Admin::ImportProductsController < Spree::Admin::BaseController
  def index
    @import_products = ImportProduct.all
    @new_import_product = ImportProduct.new
  end

  def create
    @import_products = ImportProduct.new(import_products_params)
    if @import_products.save?
      ProductImportsWorker.perform_async(@import_products.id)
      flash[:notice] = 'Products are processing'
    else
      flash[:error] = @import_products.errors.full_messages
    end
    redirect_to admin_import_products_url
  end
  4
  private

    def import_products_params
      params.require(:import_product, {}).permit(:file)
    end
end
