class UrlMapping < ApplicationRecord
  LONG_URL_MAX_LENGTH = 255

  validates :long_url, length: { maximum: LONG_URL_MAX_LENGTH }
  validates :long_url, url_syntax: true
end
