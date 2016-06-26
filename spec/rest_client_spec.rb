require 'spec_helper'

describe "Mercadopago::RestClient" do
  let(:rest_client) { Mercadopago.client.rest_client }
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
        allow(http_stub).to receive(:code).and_return("200")
        allow(http_stub).to receive(:body).and_return("{}")
        allow(rest_client.http).to receive(:send_request) do |arg1, arg2, arg3, arg4|
        end.and_return(http_stub)
      end
      it { expect(rest_client.get("/v1/payments")[:status]).to eq("200") }
    end

    context 'when API endpoint\'s call response is a bad request' do
      before do
        http_stub = double
        allow(http_stub).to receive(:code).and_return("400")
        allow(http_stub).to receive(:body).and_return("{}")
        allow(rest_client.http).to receive(:send_request) do |arg1, arg2, arg3, arg4|
        end.and_return(http_stub)
      end
      it { expect(rest_client.get("/v1/payments")[:status]).to eq("400") }
    end
  end
end
