# frozen_string_literal: true

require './api/exceptions/core_exception'

module Rescues
  def self.included(base)
    base.class_eval do
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        Logs.error("Validation error raised #{e.message}, 422")
        error!({ status: 'fail', code: 'VALIDATION_ERROR', data: { message: e.message } }, 422)
      end
      rescue_from StandardError do |e|
        Logs.error(e.exception)
        error!({ status: 'fail', code: 'STANDARD_ERROR', data: { cause: e.cause } }, 500)
      end
    end
  end
end
