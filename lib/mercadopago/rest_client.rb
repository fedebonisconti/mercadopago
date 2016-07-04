require 'uri'
require 'net/https'
require 'json'
require 'mercadopago/config'
require 'mercadopago/response'

module Mercadopago
  class RestClient
    attr_accessor :http, :api_base_uri
    attr_reader :access_token, :public_key, :client_secret, :query

    MIME_JSON = 'application/json'.freeze
    MIME_FORM = 'application/x-www-form-urlencoded'.freeze
    API_BASE_URL = 'https://api.mercadopago.com'.freeze
    MERCADO_PAGO_VERSION = '0.3.4'.freeze
    API_VERSION = '/v1'.freeze
    GET = "GET".freeze
    POST = "POST".freeze
    PUT = "PUT".freeze
    DELETE = "DELETE".freeze

    def initialize(opts = {})
      @access_token = opts[:access_token] || Config.access_token
      @public_key = opts[:public_key] || Config.public_key
      @http = set_http
    end

    def generate_uri(uri, params = {})
      params['access_token'] = access_token
      @query ||= (uri.include?("?") ? "&" : "?") +
        URI.encode_www_form(params)
      API_VERSION + uri + @query
    end

    def get(uri, params = {}, content_type = MIME_JSON)
      request(GET, uri, params, content_type)
    end

    def post(uri, data, params = {}, content_type = MIME_JSON)
      request(POST, uri, params, content_type, data)
    end

    def put(uri, data = nil, params = {}, content_type = MIME_JSON)
      request(PUT, uri, params, content_type, data)
    end

    def delete(uri, params = {}, content_type = MIME_JSON)
      request(DELETE, uri, params, content_type)
    end

    def api_base_uri
      @api_base_uri ||= URI.parse(API_BASE_URL)
    end

    def request(method, uri, params, content_type, data = {})
      api_result = http.send_request(method, generate_uri(uri, params), data.to_json, headers(content_type))
      Response.new(api_result.code, JSON.parse(api_result.body))
    end

    private
    def headers(content_type)
      {
        'User-Agent' => "MercadoPago Ruby SDK v" + MERCADO_PAGO_VERSION,
        'Content-type' => content_type,
        'Accept' => MIME_JSON
      }
    end

    def set_http
      http = Net::HTTP.new(api_base_uri.host, api_base_uri.port)
      if api_base_uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        # TODO: review this option
        # @http.ssl_version = OpenSSL::SSL::OP_NO_SSLv3
      end
      http
    end
  end
end
