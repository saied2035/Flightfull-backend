require 'swagger_helper'

describe 'api/v1/reservation' do
  path '/api/v1/users/{user_id}/reservations' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    get('list reservations') do
      tags 'Reservations'
      response(200, 'successful') do
        let(:user_id) { '1' }
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

    post('create reservation') do
      tags 'Reservations'
      response(200, 'successful') do
        let(:user_id) { '1' }
        consumes 'application/json'
        parameter name: :item, in: :body, schema: {
          type: :object,
          properties: {
            date: { type: :string, format: :timestamp, required: true },
            city: { type: :string },
            user_id: { type: :integer },
            item_id: { type: :integer }
          },
          required: %w[date city user_id item_id]
        }

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
  end

  path '/api/v1/users/{user_id}/reservations/{id}' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'
    delete('delete reservation') do
      tags 'Reservations'
      response(200, 'successful') do
        let(:user_id) { '1' }
        let(:id) { '1' }
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
  end
end
