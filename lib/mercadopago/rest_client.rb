require 'uri'

module Mercadopago
  class RestClient
    attr_accessor :api_base_url

    MIME_JSON = 'application/json'
    MIME_FORM = 'application/x-www-form-urlencoded'
    API_BASE_URL = URI.parse('https://api.mercadopago.com')

    def get(uri, content_type = MIME_JSON)

    end

    def post(uri, data = nil, content_type = MIME_JSON)

    end

    def put(uri, data = nil, content_type = MIME_JSON)

    end

    def delete(uri, content_type = MIME_JSON)

    end

    def api_base_url
      @api_base_url ||= API_BASE_URL
    end

    private
    def headers(content_type)
			{
        'User-Agent' => "MercadoPago Ruby SDK v" + MERCADO_PAGO_VERSION,
        'Content-type' => content_type,
        'Accept' => MIME_JSON
      }
    end
  end
end
