# frozen_string_literal: true

max_threads = Integer(ENV.fetch('PUMA_MAX_THREADS', 5))
min_threads = Integer(ENV.fetch('PUMA_MIN_THREADS', max_threads))
threads min_threads, max_threads

port ENV.fetch('PORT', 8080)

rackup File.expand_path('../config.ru', __dir__)

environment ENV.fetch('RACK_ENV', 'development')

worker_count = Integer(ENV.fetch('PUMA_WORKERS', 0))
workers worker_count if worker_count.positive?

preload_app!
plugin :tmp_restart
