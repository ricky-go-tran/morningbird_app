class ApplicationController < ActionController::Base

  private

  def check_auth
    credential = CredentialShopify.find_by(shop: params[:shop])
    binding.pry
    if credential.nil?
      redirect_to "/auth/shopify/credentials?host=#{params[:host]}&shop=#{params[:shop]}&timestamp=#{params[:timestamp]}&hmac=#{params[:hmac]}"
    end
  end
end
