require 'spec_helper'
require 'capybara/rspec'
require_relative '../app'

Capybara.app = App

feature "Manages Items" do

  before :each do
    DB[:tasks].delete
  end

  scenario "User adds items to list" do

    visit '/'
    expect(page).to_not have_content("First Item")
    fill_in "add_item", with: "First Item"
    click_on "Submit"
    expect(page).to have_content("First Item")

  end

end

