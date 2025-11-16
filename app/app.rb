# frozen_string_literal: true

require 'json'
require 'rack'

module ClaviusTales
  # Rack application that handles the public endpoints.
  class App
    def call(env)
      request = Rack::Request.new(env)

      case [request.request_method, request.path_info]
      when ['GET', '/']
        ok(payload(message: 'Welcome to the Clavius Tales backend'))
      when ['GET', '/health']
        ok(payload(status: 'ok', time: Time.now.utc))
      else
        not_found
      end
    end

    private

    def payload(data)
      JSON.generate(data)
    end

    def ok(body)
      response(200, body)
    end

    def not_found
      response(404, payload(error: 'Route not found'))
    end

    def response(status, body)
      [status, { 'Content-Type' => 'application/json' }, [body]]
    end
  end
end
