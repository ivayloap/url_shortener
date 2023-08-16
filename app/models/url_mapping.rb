class UrlMapping < ApplicationRecord
  LONG_URL_MAX_LENGTH = 100

  validates :long_url, length: { maximum: LONG_URL_MAX_LENGTH }
  validate :url_syntax

  private

  def url_syntax
    return if long_url.blank?

    uri = URI.parse(long_url)
    add_invalid_url_error unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    add_invalid_url_error
  end

  def add_invalid_url_error
    errors.add(:long_url, 'is not a valid URL')
  end
end
