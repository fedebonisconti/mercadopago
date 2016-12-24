require 'spec_helper'

describe "Mercadopago::RestClient" do
  let(:rest_client) { Mercadopago.client.rest_client }
  let(:endpoint) { "/v1/payments" }
  let(:url) { MERCADOPAGO_API + rest_client.request_uri(endpoint) }
  let(:headers) { rest_client.headers(Mercadopago::RestClient::MIME_JSON) }

  before(:each) do
    Mercadopago.configure do |config|
      config.access_token = 'foo_bar_access_token'
      config.public_key = 'foo_bar_public_key'
    end
  end

  describe 'rest_client' do
    context 'when API endpoint\'s call response is ok' do
      it do
        stub_request(:get, url)
        .with( :body => "{}", :headers => headers )
        .to_return(:status => 200, :body => "{}", :headers => {})
        expect(rest_client.get(endpoint)[:status]).to eq("200")
      end
    end

    context 'when API endpoint\'s call response is a bad request' do
      it do
        stub_request(:get, url)
        .with( :body => "{}", :headers => headers )
        .to_return(:status => 400, :body => "{}", :headers => {})
        expect(rest_client.get(endpoint)[:status]).to eq("400")
      end
    end
  end
end
