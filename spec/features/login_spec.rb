require 'rails_helper'

describe "Log in" do
  before(:each) do
    user = create(:user)
    visit root_path
    visit log_in_path
  end

  it "as not a member" do
    fill_in "Email", with: "steve@apple.com"
    fill_in "Password", with: "k"
    click_button "Log in"
    expect(page).to have_content("Email or password was invalid.")
  end

  it "as a member" do
    fill_in "Email", with: "steve@apple.com"
    fill_in "Password", with: "applebeforeapple"
    click_button "Log in"
    expect(page).to have_content("Welcome back")
  end
end