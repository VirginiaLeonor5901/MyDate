# frozen_string_literal: true

require './api/dao/user_dao'

module Routes
  module V1
    module Endpoints
      class Users < Grape::API
        resource :users do
          params do
            with(type: String, allow_blank: false) { requires :phone, :password }
          end
          post :register do
            DAO::UserDAO.instance.add(params)
            { status: :success }
          end

          params do
            with(type: String, allow_blank: false) { requires :phone, :password }
          end
          post :login do
            user = DAO::UserDAO.instance.search(phone: params[:phone])

            return { status: :fail, data: 'User not found' } unless user
            return { status: :fail, data: 'Incorrect password' } unless user.password == params[:password]

            return { status: :success, data: user.id }
          end

          route_param :id, { type: Integer, allow_blank: false } do
            get :products do
              user = DAO::UserDAO.instance.search(id: params[:id])
              products = user.products.map(&:to_hash)

              { status: :success, data: products }
            end
          end
        end
      end
    end
  end
end
