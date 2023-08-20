FactoryBot.define do
  factory :url_mapping do
    long_url { 'https://example.com' }
    short_url { 'short-url-suffix'}
  end
end