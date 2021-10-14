class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV["ADMIN_PRODUCTS_USERNAME"], password: ENV["ADMIN_PRODUCTS_PASSWORD"]

  def index
    @categories = Category.all
  end

  def new
  end

  def create
  end

end