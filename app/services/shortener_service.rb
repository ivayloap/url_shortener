class ShortenerService
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def encode
    File.join(url_host, encoded.short_url)
  end

  def decode
    Rails.cache.fetch(cache_key, expires_in: ENV.fetch('READ_CACHE_EXPIRATION_HOURS', 1).hours) do
      by_short_url.long_url
    end
  end

  private

  def cache_key
    "ShorteningService:Decode:#{url}"
  end

  def by_short_url
    UrlMapping.find_by_short_url!(short_url_path)
  end

  def by_long_url
    UrlMapping.create_or_find_by!(long_url: url)
  end

  def short_url_path
    url.split('/').last
  end

  def encoded
    @encoded ||= begin
      record = by_long_url
      record.update short_url: Base62.encode(url_base + record.id) unless record.short_url
      record
    end
  end

  def url_base
    ENV.fetch('SHORT_URL_BASE', 1_000_000).to_i
  end

  def url_host
    ENV.fetch('SHORT_URL_HOST', 'https://short.est/')
  end
end