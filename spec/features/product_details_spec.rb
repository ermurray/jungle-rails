require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: 'Apparel'
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
 
  end
  
  scenario "users can navigate from home page to product detail page by clicking on a product" do
    
  visit root_path
  find('a.btn-default').click
  save_screenshot

  expect(page).to have_content('Name')
  end

end
