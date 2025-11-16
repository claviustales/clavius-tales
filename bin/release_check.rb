#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'rack'
require 'stringio'

$LOAD_PATH.unshift File.expand_path('../app', __dir__)
require 'app'

# Smoke tests run as release_command on Fly to ensure endpoints respond.
class ReleaseCheck
  def initialize(app = ClaviusTales::App.new)
    @app = app
  end

  def call
    check_root
    check_health
    puts 'Release check passed'
  end

  private

  attr_reader :app

  def check_root
    status, headers, body = request('GET', '/')
    assert(status == 200, "GET / expected 200, got #{status}")
    assert(headers['Content-Type'] == 'application/json', 'GET / wrong content type')

    data = parse_json(body)
    assert(data['message'], 'GET / missing message')
  end

  def check_health
    status, _headers, body = request('GET', '/health')
    assert(status == 200, "GET /health expected 200, got #{status}")

    data = parse_json(body)
    assert(data['status'] == 'ok', 'GET /health missing ok status')
    assert(data['time'], 'GET /health missing time')
  end

  def request(method, path)
    env = rack_env(method, path)
    status, headers, body = app.call(env)
    [status, headers, Array(body).join]
  end

  def rack_env(method, path)
    common_env.merge(
      'REQUEST_METHOD' => method,
      'PATH_INFO' => path
    )
  end

  def common_env
    {
      'QUERY_STRING' => '',
      'SERVER_NAME' => 'localhost',
      'SERVER_PORT' => '80',
      'rack.url_scheme' => 'http',
      'rack.input' => StringIO.new,
      'rack.errors' => $stderr,
      'rack.version' => Rack::VERSION
    }
  end

  def parse_json(body)
    JSON.parse(body)
  rescue JSON::ParserError => e
    abort("Invalid JSON response: #{e.message}")
  end

  def assert(condition, message)
    return if condition

    abort(message)
  end
end

ReleaseCheck.new.call
