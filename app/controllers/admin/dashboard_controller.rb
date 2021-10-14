class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV["ADMIN_PRODUCTS_USERNAME"], password: ENV["ADMIN_PRODUCTS_PASSWORD"]

  def show
  end
end
