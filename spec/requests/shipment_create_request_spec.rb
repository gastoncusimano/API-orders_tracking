 
require 'rails_helper'

RSpec.describe 'Shipments', type: :request do
  describe 'POST /create_shipment' do
    context 'when the request is valid' do
      let(:shipment_params) { { courier: 'fedex', tracking_reference: 'test' } }
      before { post '/create_shipment', params: shipment_params }

      it 'creates shipment' do
        json = JSON.parse(response.body)
        expect(json['data']['courier']).to eq('fedex')
        expect(json['data']['tracking_reference']).to eq('test')
        expect(json['data']['tracking_status']).to eq('created')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:shipment_params) { {} }
      before { post '/create_shipment', params: shipment_params }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation error message' do
        expect(response.body).to match(
          "[\"Courier can't be blank\",\"Tracking reference can't be blank\"]"
        )
      end
    end

    context 'when the courier is invalid' do
        let(:shipment_params) { { courier: 'invalid', tracking_reference: 'test' } }
        before { post '/create_shipment', params: shipment_params }
  
        it 'returns status code 400' do
          expect(response).to have_http_status(400)
        end
  
        it 'returns a validation error message' do
          expect(response.body).to match(
            "[\"Courier is not included in the list\"]"
          )
        end
      end
  end
end