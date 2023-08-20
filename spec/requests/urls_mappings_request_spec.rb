require 'rails_helper'

RSpec.describe UrlsMappingsController, type: :request do
  describe 'POST #encode' do
    context 'with a valid URL' do
      let(:valid_url) { 'https://www.example.com' }

      it 'encodes and returns a short URL' do
        post '/encode', params: { url: valid_url }
        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['short_url']).to be_present
      end
    end

    context 'with an invalid URL' do
      let(:invalid_url) { 'invalid-url' }

      it 'returns an error message' do
        post '/encode', params: { url: invalid_url }
        expect(response).to have_http_status(:bad_request)
        parsed_response = JSON.parse(response.body)
        expect(response).to be_bad_request
        expect(parsed_response['error']).to eq("The provided URI is not correct -> 'invalid-url'")
      end
    end
  end

  describe 'POST #decode' do
    context 'with a valid short URL' do
      let!(:url_mapping) { create(:url_mapping) }

      it 'decodes and returns the corresponding long URL' do
        post '/decode', params: { short_url: 'https://short_url_host.com/' + url_mapping.short_url }
        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['long_url']).to eq url_mapping.long_url
      end
    end

    context 'with an invalid short URL' do
      let(:invalid_short_url) { 'invalid-short-url' }

      it 'returns an error message' do
        post '/decode', params: { short_url: invalid_short_url }
        expect(response).to have_http_status(:bad_request)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq('Resource not found')
      end
    end
  end
end
