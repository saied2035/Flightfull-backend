require 'swagger_helper'

describe 'api/v1/items' do
  path '/api/v1/items' do
    get('list items') do
      tags 'Items'
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

    post('create Item') do
      tags 'Items'
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :item, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            flight_number: { type: :integer },
            price: { type: :integer },
            image: { type: :string },
            user_id: { type: :integer }
          },
          required: %w[name flight_number price image user_id]
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
          response '201', 'created' do
            let(:item) do
              { name: 'test', flight_number: 1234, price: 1000, image: 'image.png',
                user_id: 1 }
            end
            run_test!
          end
          response '401', 'bad request' do
            let(:item) do
              { name: '', flight_number: 1234, price: 1000, image: 'photo.jpeg',
                user_id: 1 }
            end
            run_test!
          end
        end
        run_test!
      end
    end
  end

  path '/api/v1/items/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    # get('show details') do
    #   tags 'Items'
    #   response(200, 'successful') do
    #     let(:id) { '1' }

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    delete('delete item') do
      tags 'Items'
      response(200, 'successful') do
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
