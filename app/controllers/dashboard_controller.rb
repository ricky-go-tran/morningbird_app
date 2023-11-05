class DashboardController < ApplicationController
  before_action :check_auth, only: %i[index]
  def index
    if ShopifyAPI::Context.embedded? && (!params[:embedded].present? || params[:embedded] != '1')
      embedded_url = ShopifyAPI::Auth.embedded_app_url(params[:host])
      redirect_to embedded_url, allow_other_host: true
    else
      render :index
    end
  end
end
