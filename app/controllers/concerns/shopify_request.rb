module ShopifyRequest
  extend ActiveSupport::Concern

  SHOPIFY_AUTHENTICATE_ACCEPTS_PARAMS = %w[host shop timestamp].freeze

  private

  def shopify_request_params
    params.permit!.to_h
  end

  def shopify_authenticate_without_hmac(raw_hash)
    raw_hash.select { |key, _value| SHOPIFY_AUTHENTICATE_ACCEPTS_PARAMS.include?(key) }
  end

  def hash_to_query_string(hash)
    hash.map { |key, value| "#{key}=#{value}" }.join('&')
  end
end
