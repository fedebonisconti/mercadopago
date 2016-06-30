require 'spec_helper'

describe "Mercadopago::RestClient" do
  let(:rest_client) { Mercadopago.client.rest_client }
  let(:status_ok) { "200" }
  let(:status_error) { "400" }
  let(:empty_string_hash) { "{}" }

  before(:each) do
    Mercadopago.configure do |config|
      config.access_token = 'foo_bar_access_token'
      config.public_key = 'foo_bar_public_key'
    end
  end

  describe 'rest_client' do
    context 'when API endpoint\'s call response is ok' do
      before do
        http_stub = double
        allow(http_stub).to receive(:code).and_return(status_ok)
        allow(http_stub).to receive(:body).and_return(empty_string_hash)
        allow(rest_client.http).to receive(:send_request) do |arg1, arg2, arg3, arg4|
        end.and_return(http_stub)
      end
      it { expect(rest_client.get("/v1/payments")[:status]).to eq(status_ok) }
    end

    context 'when API endpoint\'s call response is a bad request' do
      before do
        http_stub = double
        allow(http_stub).to receive(:code).and_return(status_error)
        allow(http_stub).to receive(:body).and_return(empty_string_hash)
        allow(rest_client.http).to receive(:send_request) do |arg1, arg2, arg3, arg4|
        end.and_return(http_stub)
      end
      it { expect(rest_client.get("/v1/payments")[:status]).to eq(status_error) }
    end
  end
end
