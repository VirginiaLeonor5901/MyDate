# frozen_string_literal: true

require 'dry-container'
require 'dry-auto_inject'
require 'sequel'
require_relative 'service_config'

class Services
  extend Dry::Container::Mixin

  register :database, memoize: true do
    configuration = ServiceConfig[:configuration]

    db_config = {
      adapter: 'postgres',
      host: configuration['DB_HOST'],
      database: configuration['DB_NAME'],
      user: configuration['DB_USER'],
      password: configuration['DB_PASSWORD']
    }

    Sequel.connect(db_config.merge({ database: 'postgres' })) do |database|
      puts 'Creating database'
      database.execute "CREATE DATABASE \"#{db_config[:database]}\""
    rescue StandardError
      puts 'Database already exists'
    end

    Sequel.connect(db_config)
  end
end

ServicesContainer = Dry::AutoInject(Services)
