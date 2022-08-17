# frozen_string_literal: true

require 'dry-container'
require 'dry-auto_inject'
require_relative 'config'

require 'dotenv'
Dotenv.overload

class ServiceConfig
  extend Dry::Container::Mixin

  register :configuration, memoize: true do
    Config.load_config
  end
end

ConfigContainer = Dry::AutoInject(ServiceConfig)
