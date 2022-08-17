# frozen_string_literal: true

require 'grape'
require './api/routes/v1/routes'
require './config/services'

module API
  class Root < Grape::API
    mount Routes::V1::API
  end
end
