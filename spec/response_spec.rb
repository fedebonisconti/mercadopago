require 'spec_helper'

describe "Mercadopago::Response" do
  let(:status) { "200" }
  let(:response) { {"id": 1234} }
  let(:response_object) { Mercadopago::Response.new(status, response) }

  describe 'response' do
    context 'when sended status to response_object' do
      it { expect(response_object.status).to eq(status) }
    end

    context 'when sended response to response_object' do
      it { expect(response_object.response).to eq(response) }
    end

    context 'when sended method to response_object and response contains method name' do
      it { expect(response_object.respond_to?(:id)).to be_truthy }
    end

    context 'when sended method to response_object and response contains method name' do
      it { expect(response_object.id).to eq(response[:id]) }
    end
  end
end
