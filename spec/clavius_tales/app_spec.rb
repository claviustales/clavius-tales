# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClaviusTales::App do
  describe 'GET /' do
    subject(:response) do
      get '/'
      last_response
    end

    let(:response_body) { JSON.parse(response.body) }

    it 'responds with 200' do
      expect(response).to be_ok
    end

    it 'returns JSON content type' do
      expect(response.headers['Content-Type']).to eq('application/json')
    end

    it 'returns welcome message' do
      expect(response_body['message']).to eq('Welcome to the Clavius Tales backend')
    end
  end

  describe 'GET /health' do
    subject(:response) do
      get '/health'
      last_response
    end

    let(:response_body) { JSON.parse(response.body) }

    it 'responds with 200' do
      expect(response).to be_ok
    end

    it 'returns ok status' do
      expect(response_body['status']).to eq('ok')
    end

    it 'returns the current time' do
      expect(response_body['time']).not_to be_nil
    end
  end

  describe 'GET /unknown' do
    subject(:response) do
      get '/unknown'
      last_response
    end

    let(:response_body) { JSON.parse(response.body) }

    it 'responds with 404' do
      expect(response.status).to eq(404)
    end

    it 'returns not found message' do
      expect(response_body['error']).to eq('Route not found')
    end
  end
end
