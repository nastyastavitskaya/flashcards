require 'rails_helper'

describe "Registration" do
  before(:each) do
    visit root_path
    visit log_in_path
    click_link "Sign up now"
    visit sign_up_path
  end

  it "as a new member" do
    fill_in "Name", with: "new member"
    fill_in "Email", with: "newmember@gmail.com"
    fill_in "Password", with: "blabla"
    fill_in "Confirm Password", with: "blabla"
    click_button "Register"
    expect(page).to have_css(".alert-success")
    visit root_path
  end

  it "with errors" do
    fill_in "Name", with: "new member"
    fill_in "Email", with: "newmember@gmail.com"
    fill_in "Password", with: " "
    fill_in "Confirm Password", with: "blabla"
    click_button "Register"
    expect(page).to have_css(".alert")
  end
end
