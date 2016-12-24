require 'spec_helper'

describe "Mercadopago::Client" do
  let(:client) { Mercadopago.client }
  let(:api_endpoint) { :some_invalid_endpoint }
  before(:each) do
    Mercadopago.configure do |config|
      config.access_token = 'foo_bar_access_token'
      config.public_key = 'foo_bar_public_key'
    end
  end

  describe 'card_token' do
    context 'when API endpoint is invalid' do
      it { expect{ client.card_token(:api_endpoint)}.to raise_error(Mercadopago::Errors::Endpoint)}
    end
  end
end
