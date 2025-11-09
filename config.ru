# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("./app", __dir__)

require "app"

run ClaviusTales::App.new
