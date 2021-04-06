require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "They see the number of items in cart next to cart icon" do
    
    visit root_path
    save_screenshot
    
    click_button('Add')

    expect(page).to have_content('My Cart (1)')

  end

end
