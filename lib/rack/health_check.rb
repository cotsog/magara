# frozen_string_literal: true

module Rack
  # Provides an endpoint for to check Redis, PostgreSQL connection and pending
  # migrations.
  #
  # == Usage
  #
  #   require_relative 'config/environment'
  #   require_relative 'lib/rack/health_check'
  #
  #   map '/health' do
  #     run Rack::HealthCheck.new
  #   end
  #
  #   run Rails.application
  class HealthCheck
    def call(_env)
      status = {
        redis: {
          connected: redis_connected
        },
        postgres: {
          connected: postgres_connected,
          migrations_pending: postgres_migrations_pending
        }
      }

      [200, {}, [status.to_json]]
    end

    protected

    def redis_connected
      $redis.ping == 'PONG'
    rescue StandardError
      false
    end

    def postgres_connected
      ApplicationRecord.establish_connection
      ApplicationRecord.connection
      ApplicationRecord.connected?
    rescue StandardError
      false
    end

    def postgres_migrations_pending
      return false unless postgres_connected

      ApplicationRecord.connection.migration_context.needs_migration?
    end
  end
end
