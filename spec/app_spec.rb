# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClaviusTales::App do
  describe "GET /" do
    it "returns welcome message" do
      get "/"

      expect(last_response).to be_ok
      expect(last_response.headers["Content-Type"]).to eq("application/json")

      body = JSON.parse(last_response.body)
      expect(body["message"]).to eq("Bem-vindo ao backend da Clavius Tales")
    end
  end

  describe "GET /health" do
    it "returns ok status and time" do
      get "/health"

      expect(last_response).to be_ok

      body = JSON.parse(last_response.body)
      expect(body["status"]).to eq("ok")
      expect(body["time"]).not_to be_nil
    end
  end

  describe "GET /unknown" do
    it "returns not found" do
      get "/unknown"

      expect(last_response.status).to eq(404)

      body = JSON.parse(last_response.body)
      expect(body["error"]).to eq("Rota não encontrada")
    end
  end
end
