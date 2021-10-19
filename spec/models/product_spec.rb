require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.new(name: 'Apparel')
    @product = Product.new(name: 'Hipster Shirt', price_cents: 5000000, quantity: 5, category: @category)
  end

  describe 'Validations' do
    it 'should save a valid product' do
      @product.save
    end

    it 'should not save without a valid name' do
      @product.name = nil
      expect(@product.valid?).to be false 
    end

    it 'should not save without a valid quantity' do
      @product.quantity = nil
      expect(@product.valid?).to be false
    end

    it 'should not save based on a missing price' do
      @product.price_cents = nil
      expect(@product.valid?).to be false
    end

    it 'should not save based on a missing category' do
      @product.category = nil
      expect(@product.valid?).to be false
    end
  end
end
