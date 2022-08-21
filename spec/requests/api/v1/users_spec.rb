# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'drivers', type: :request do
  path '/users' do
    get('list users') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create users') do
      parameter name: 'id', in: :path, type: :string, description: 'id'
      post 'Creates a user' do
        consumes 'application/json'

        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            first_name: { type: :string },
            last_name: { type: :string },
            email: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string },
            user_name: { type: :string }
          }
        }

        response '200', 'user created' do
          let(:order) { { amount: 'New Book', description: 'New Author' } }

          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['amount']).to eq('New Book')
            # new_books_in_db = Order.where(description: 'New Book').count
            expect(new_books_in_db).to eq(1)
          end
        end
      end
    end
  end

  path '/users/sign_in' do
    post 'sign_in' do
      consumes 'application/json'

      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }

      response '200', 'sign_in' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          # expect(new_books_in_db).to eq(1)
        end
      end
    end
  end
end
