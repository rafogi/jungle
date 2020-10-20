require 'rails_helper'

RSpec.feature "navigate to product detail page by clicking a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "click on pruduct and see product page" do
    visit root_path
    first('article.product').find("body > main > section > div > article:nth-child(1) > header").click
    # commented out b/c it's for debugging only
    

    expect(page).to have_css 'section.products-show', count: 1
    page.save_and_open_screenshot
  end
end