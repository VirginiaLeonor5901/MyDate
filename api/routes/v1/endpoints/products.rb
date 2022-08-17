# frozen_string_literal: true

require './api/dao/user_dao'
require './api/dao/product_dao'

module Routes
  module V1
    module Endpoints
      class Products < Grape::API
        resource :fecha do
          get do
            p 'entro aqui'
            Time.now
          end   
        end
      end
    end
  end
end
