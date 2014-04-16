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

  scenario "User deletes items to list" do

    visit '/'

    fill_in "add_item", with: "First Item"
    click_on "Submit"
    fill_in "add_item", with: "Second Item"
    click_on "Submit"
    fill_in "add_item", with: "Third Item"
    click_on "Submit"

    expect(page).to have_content("Second Item")

    within('li:nth-child(2)') do
      click_on "Delete"
    end

    expect(page).to_not have_content("Second Item")

  end

  scenario "User can complete a task" do
    visit '/'

    fill_in "add_item", with: "First Item"
    click_on "Submit"
    fill_in "add_item", with: "Second Item"
    click_on "Submit"
    fill_in "add_item", with: "Third Item"
    click_on "Submit"

    within('li:nth-child(2)') do
      click_on "&#x2713;"
    end
    expect(page).to have_css("li.completed")

  end

  scenario "User can un-complete a task" do
    visit '/'

    fill_in "add_item", with: "First Item"
    click_on "Submit"
    fill_in "add_item", with: "Second Item"
    click_on "Submit"
    fill_in "add_item", with: "Third Item"
    click_on "Submit"

    within('li:nth-child(2)') do
      click_on "&#x2713;"
    end

    expect(page).to have_css("li.completed")
    within('li.completed') do
      click_on "&#x2713;"
    end
    expect(page).to_not have_css("li.completed")

  end

end

