require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module UrlShortener
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    # config.cache_store = defined?(Redis) ? :redis_cache_store : :memory_store

    if defined?(Redis)
      config.cache_store = :redis_cache_store, {
        url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'),
        namespace: 'url_shortener',
        expires_in: 1.day
      }
    else
      config.cache_store = :memory_store
    end
  end
end
