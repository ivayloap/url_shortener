class UrlsMappingsController < ApplicationController
  def encode
    render json: { short_url: short_url }, status: :ok
  end

  def decode
    render json: { long_url: long_url }, status: :ok
  end

  private

  def short_url
    ShortenerService.new(permitted_params[:url]).encode
  end

  def long_url
    ShortenerService.new(permitted_params[:short_url]).decode
  end

  def permitted_params
    params.permit(:url, :short_url)
  end
end
