class ShopifyAuthController < ApplicationController
   include ShopifyRequest

  def login
    return unless verify_request

    shop = params[:shop]
    auth_response = ShopifyAPI::Auth::Oauth.begin_auth(
      shop:,
      redirect_path: '/auth/shopify/redirect',
      is_online: false
    )
    cookies[auth_response[:cookie].name] = {
      expires: auth_response[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_response[:cookie].value
    }
    redirect_to auth_response[:auth_route], status: 307, allow_other_host: true
  end


  def callback
    auth_query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
      code: params[:code],
      shop: params[:shop],
      timestamp: params[:timestamp],
      state: params[:state],
      host: params[:host],
      hmac: params[:hmac]
    )
    auth_result = ShopifyAPI::Auth::Oauth.validate_auth_callback(
      cookies: cookies.to_h,
      auth_query:
    )
    cookies[auth_result[:cookie].name] = {
      expires: auth_result[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_result[:cookie].value
    }
    shop = auth_result[:session].shop
    scope = auth_result[:session].scope.to_s
    access_token = auth_result[:session].access_token
    CredentialShopify.create!(shop:, scopes: scope, access_token:)
    redirect_to "/redirect?host=#{params[:host]}", status: 307
  rescue StandardError
    head 500
  end

  def redirect
    if ShopifyAPI::Context.embedded? && (!params[:embedded].present? || params[:embedded] != '1')
      embedded_url = ShopifyAPI::Auth.embedded_app_url(params[:host])
      redirect_to embedded_url, allow_other_host: true
    else
      redirect_to("/?shop=#{session.shop}&host=#{params[:host]}")
    end
  end

  private

  def verify_request
    digest = OpenSSL::Digest.new('sha256')
    param = shopify_request_params
    param_without_hmac = shopify_authenticate_without_hmac(param)
    query_string = hash_to_query_string(param_without_hmac)
    decode = OpenSSL::HMAC.hexdigest(digest, ShopifyAPI::Context.api_secret_key, query_string)
    ActiveSupport::SecurityUtils.secure_compare(decode, param[:hmac])
  end
end
