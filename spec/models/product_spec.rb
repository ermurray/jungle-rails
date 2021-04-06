require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    it "should save product if valid" do
      @category = Category.create(name:"test things")
      @product = Product.new(
        name: "stuff",
        price: 900.00,
        quantity: 10,
        category_id: @category.id
      )
      expect(@product).to be_valid
    end

    it "should be invalid without name" do
      @category = Category.create(name: 'test things')
      @product = Product.new(
        name: nil,
        price: 900.00,
        quantity: 10,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include "can't be blank"
    end
    
    it "should be invalid without price" do
      @category = Category.create(name: 'test things')
      @product = Product.new(
        name: "stuff",
        price: nil,
        quantity: 10,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include "can't be blank"
    end
   
    it "should be invalid without quantity" do
      @category = Category.create(name: 'test things')
      @product = Product.new(
        name: "stuff",
        price: 900.0,
        quantity: nil,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include "can't be blank"
    end
   
    it "should be invalid without category_id" do
      @category = Category.create(name: 'test things')
      @product = Product.new(
        name: "stuff",
        price: 900.0,
        quantity: 10,
        category_id: nil
      )
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include "can't be blank"
    end

    
  end
end
