# frozen_string_literal: true

require 'grape'
require 'sequel'
require 'time'
require 'tzinfo'

module Routes
  module V1
    class API < Grape::API
      prefix :api
      version :v1
      format :json
      get :fecha do
        TZInfo::Timezone.get('America/Havana').now.to_i
      end
    end
  end
end
