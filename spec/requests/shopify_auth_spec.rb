require 'rails_helper'

RSpec.describe "ShopifyAuths", type: :request do
  describe "GET /login" do
    it "returns http success" do
      get "/shopify_auth/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /callback" do
    it "returns http success" do
      get "/shopify_auth/callback"
      expect(response).to have_http_status(:success)
    end
  end

end
