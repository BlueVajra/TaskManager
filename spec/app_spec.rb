require 'spec_helper'
require 'capybara/rspec'
require_relative '../app'

Capybara.app = App

feature "Manages Items" do

  before :each do
    DB[:tasks].delete
    DB[:projects].delete

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

    within('.task_list li:nth-child(2)') do
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

    within('.task_list li:nth-child(2)') do
      click_on "X"
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

    within('.task_list li:nth-child(2)') do
      click_on "X"
    end

    expect(page).to have_css("li.completed")
    within('.task_list li.completed') do
      click_on "X"
    end
    expect(page).to_not have_css("li.completed")

  end
  context "project management" do
    before :each do
      visit '/'
      fill_in "add_project", with: "Project One"
      click_on "Add Project"
      fill_in "add_project", with: "Project Two"
      click_on "Add Project"
      fill_in "add_project", with: "Project Three"
      click_on "Add Project"

      fill_in "add_item", with: "First Item"
      click_on "Submit"
      fill_in "add_item", with: "Second Item"
      click_on "Submit"
    end

    scenario "user can select a project" do
      click_link('Project Three')
      expect(page).to have_content('Current Project: Project Three')
    end

    scenario "user can only add tasks to projects" do
      expect(page).to have_content("First Item")
      click_link('Project Three')
      expect(page).to_not have_content("First Item")
    end

  end

end

