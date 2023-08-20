require 'rails_helper'

RSpec.describe UrlMapping, type: :model do
  let(:url_mapping) { build(:url_mapping) }

  describe 'validations' do
    it 'is valid with a long_url less than 100 characters' do
      url_mapping.long_url = 'http://example.com'
      expect(url_mapping).to be_valid
    end

    it 'is invalid with a long_url of 100 characters or more' do
      url_mapping.long_url = 'https://' + 'a' * 255 + '.com'
      expect(url_mapping).not_to be_valid
      expect(url_mapping.errors[:long_url]).to include('is too long (maximum is 255 characters)')
    end

    it 'is valid' do
      url_mapping.long_url = 'https://www.example.com'
      expect(url_mapping).to be_valid
    end

    it 'is invalid' do
      url_mapping.long_url = 'invalid-url'
      expect {
        url_mapping.valid?
      }.to raise_error(Errors::InvalidUrlError, "The provided URI is not correct -> 'invalid-url'")
    end
  end
end
