require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should create a product if name price quantity category is present' do
      @category = Category.new(name:"apparel")
      @product = Product.new(name:"just a test", price:1000, quantity:10, category: @category)
      @product.valid?
      expect(@product.errors.full_messages.length).to eql(0)
    end

    it 'should should return error message for name' do
      @category = Category.new(name:"apparel")
      @product = Product.new(name:nil, price:1000, quantity:5, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should should return error message for price' do
      @category = Category.new(name:"apparel")
      @product = Product.new(name:"hello", price:nil, quantity:5, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end

    it 'should should return error message for quantity' do
      @category = Category.new(name:"apparel")
      @product = Product.new(name:"hello", price:1000, quantity:nil, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should should return error message for quantity' do
      @product = Product.new(name:"hello", price:1000, quantity:15, category: nil)
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end