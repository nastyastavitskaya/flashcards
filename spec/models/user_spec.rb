require 'rails_helper'

describe User do

  it { should have_many(:cards) }


  describe "user name" do
    it "should not be too long" do
      user = User.new name: "a" * 51
      expect(user).not_to be_valid
    end
  end

  describe "user email" do
    it "have invalid format" do
      user = User.new email: "user@example"
      expect(user).not_to be_valid
    end
  end


  describe "#downcase_email" do
    it "makes the email attributes lower case" do
      user = User.create(email: "USER@EXAMPLE.COM")
      expect{ user.downcase_email}.to change{ user.email }.
      from("USER@EXAMPLE.COM").to("user@example.com")
    end
  end

  describe "user password" do
    it "is not valid without a password" do
      user = User.new password: nil, password_confirmation: nil
      expect(user).not_to be_valid
    end

    it "should not be valid with a confirmation mismatch" do
      user = User.new password: "iq", password_confirmation: "iq"
      expect(user).not_to be_valid
    end

    context "existing user" do
      let(:user) do
        u = User.create name: "gogol",
                         email: "gogol@gmail.com",
                         password: "flower",
                         password_confirmation: "flower"
      end

      it "should be valid with no changes" do
        expect(user).to be_valid
      end

      it "should be valid with a new password" do
        user.password = user.password_confirmation = "newpassword"
        expect(user).to be_valid
      end
    end
  end
end

