require 'rails_helper'

describe "Registration" do
  before(:each) do
        visit root_path
        visit log_in_path
        click_link "Sign up now"
    end



  it "as a new member" do
    visit sign_up_path
    fill_in "Name", with: "new member"
    fill_in "Email", with: "newmember@gmail.com"
    fill_in "Password", with: "blabla"
    fill_in "Confirm Password", with: "blabla"
    click_button "Register"
    visit root_path
  end

  it "with errors" do
    visit sign_up_path
    fill_in "Name", with: "new member"
    fill_in "Email", with: "newmember@gmail.com"
    fill_in "Password", with: " "
    fill_in "Confirm Password", with: "blabla"
    click_button "Register"
    expect(page).to have_content "Registration 2 errors prohibited this user from being saved: * Password is too short (minimum is 3 characters) * Password confirmation doesn't match Password Name Email Password Confirm Password"
  end

end
