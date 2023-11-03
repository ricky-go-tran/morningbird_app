class DashboardController < ApplicationController
  before_action :check_auth, only: %i[index]
  def index
    render :index
  end

  private

  def check_auth
    credential = CredentialShopify.find_by(shop: params[:shop])
    if credential.nil?
      redirect_to "/auth/shopify/credentials?host=#{params[:host]}&shop=#{params[:shop]}&timestamp=#{params[:timestamp]}&hmac=#{params[:hmac]}"
    end
  end
end
