require 'rails_helper'

describe User do

  it { should have_many(:cards) }
  it { should have_many(:categories)}


  describe "user name" do
    it "should not be too long" do
      @user = User.new(name: "a" * 51)
      expect(@user).not_to be_valid
    end
  end

  describe "user email" do
    it "have invalid format" do
      @user = User.new(email: "user@example")
      expect(@user).not_to be_valid
    end
  end


  describe "user password" do
    it "is not valid without a password" do
      @user = User.new(password: nil, password_confirmation: nil)
      expect(@user).not_to be_valid
    end

    it "should not be valid with a confirmation mismatch" do
      @user = User.new(password: "iq", password_confirmation: "iq")
      expect(@user).not_to be_valid
    end

    describe "existing user" do
      before(:each) do
        @user = create(:user)
      end

      it "should be valid with no changes" do
        expect(@user).to be_valid
      end

      it "should be valid with a new password" do
        @user.password = @user.password_confirmation = "applebeforeapple"
        expect(@user).to be_valid
      end
    end
  end

  describe "notify user" do
    it "sends an email" do
      email_user = User.create(
        name: "Tim",
        email: "tim@email.com",
        password: "oneone",
        password_confirmation: "oneone"
        )
      category = Category.create(
        name: "first",
        user_id: email_user.id
        )
      card_one = Card.create(
        original_text: "katze",
        translated_text: "cat",
        category_id: category.id,
        review_date: DateTime.current - 7.days
        )
      expect { User.notify_pending_cards }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
