require 'rails_helper'

describe OauthsController do

  describe "GET 'oauth'" do
    it "call provider for authorization" do
      allow(controller).to receive(:login_at).and_raise('Ignore: no view for this action')
      expect(controller).to receive(:login_at).with("facebook")
      expect { get "oauth", provider: "facebook"}.to raise_error('Ignore: no view for this action')
    end
  end

  describe "GET 'callback'" do
    it "creates a new user" do
      allow(controller).to receive(:login_from).with("facebook").and_return(nil)
      user = User.new(name: "Rocky", email: "rocky@mail.com")
      allow(controller).to receive(:create_from).with("facebook").and_return(user)

      get "callback", provider: "facebook", code: "1234567890"
      expect(response).to redirect_to(root_path)
      expect(controller.current_user).to eq(user)
    end
  end
end