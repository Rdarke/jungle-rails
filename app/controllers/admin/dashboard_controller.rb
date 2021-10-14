class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV["ADMIN_PRODUCTS_USERNAME"], password: ENV["ADMIN_PRODUCTS_PASSWORD"]

  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
