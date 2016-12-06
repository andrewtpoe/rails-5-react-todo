require "rails_helper"

RSpec.describe "The application", js: true do
  scenario "displays the spa on the root path" do
    visit root_path
    expect(page).to have_content("Hello, world!")
  end
end
