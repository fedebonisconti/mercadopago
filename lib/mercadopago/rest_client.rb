require 'uri'
require 'net/https'

module Mercadopago
  class RestClient
    attr_accessor :http, :api_base_uri
    attr_reader :sandbox_mode, :access_token, :client_id,
      :client_secret, :query

    MIME_JSON = 'application/json'
    MIME_FORM = 'application/x-www-form-urlencoded'
    API_BASE_URL = 'https://api.mercadopago.com'
    MERCADO_PAGO_VERSION = '0.3.4'


    def initialize(opts = {})
      config = ::Mercadopago::Config
      @access_token = opts[:access_token] || config.access_token
      @public_key = opts[:public_key] || config.public_key
      @sandbox_mode = opts[:sandbox_mode] || config.sandbox_mode || true

      @http = Net::HTTP.new(api_base_uri.host, api_base_uri.port)
      set_https if api_base_uri.scheme == "https"
    end

    def query(data)
      @query ||= URI.escape(data.map { |k, v| "#{k}=#{v}" }.join('&'))
    end

    def get(uri, content_type = MIME_JSON)
      request("GET", uri, content_type)
    end

    def post(uri, data = nil, content_type = MIME_JSON)
      request("POST", content_type, query(data))
    end

    def put(uri, data = nil, content_type = MIME_JSON)
      request("PUT", content_type, query(data))
    end

    def delete(uri, content_type = MIME_JSON)
      request("DELETE", content_type)
    end

    def api_base_uri
      @api_base_uri ||= URI.parse(API_BASE_URL)
    end

    def request(method, uri, content_type, data = nil)
      api_result = @http.send_request(method, uri, data, headers(content_type))
      {
        "status" => api_result.code,
        "response" => JSON.parse(api_result.body)
      }
    end

    private
    def headers(content_type)
      {
        'User-Agent' => "MercadoPago Ruby SDK v" + MERCADO_PAGO_VERSION,
        'Content-type' => content_type,
        'Accept' => MIME_JSON
      }
    end

    def set_https
    	@http.use_ssl = true
    	@http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      # TODO: review this option
    	# @http.ssl_version = OpenSSL::SSL::OP_NO_SSLv3
    end

  end
end
