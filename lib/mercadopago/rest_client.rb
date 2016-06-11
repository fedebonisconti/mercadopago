require 'uri'
require 'net/https'
require 'json'
require 'mercadopago/config'

module Mercadopago
  class RestClient
    attr_accessor :http, :api_base_uri
    attr_reader :sandbox_mode, :access_token, :public_key,
      :client_secret, :query

    MIME_JSON = 'application/json'.freeze
    MIME_FORM = 'application/x-www-form-urlencoded'.freeze
    API_BASE_URL = 'https://api.mercadopago.com'.freeze
    MERCADO_PAGO_VERSION = '0.3.4'.freeze
    API_VERSION = '/v1'.freeze


    def initialize(opts = {})
      @access_token = opts[:access_token] || Config.access_token
      @public_key = opts[:public_key] || Config.public_key
      @sandbox_mode = opts[:sandbox_mode] || Config.sandbox_mode || true

      @http = Net::HTTP.new(api_base_uri.host, api_base_uri.port)
      @http.set_debug_output $stdout
      set_https if api_base_uri.scheme == "https"
    end

    def generate_uri(uri, params = {})
      params['access_token'] = access_token
      @query ||= (uri.include?("?") ? "&" : "?") +
        URI.encode_www_form(params)
      API_VERSION + uri + @query
    end

    def get(uri, params = {}, content_type = MIME_JSON)
      request("GET", generate_uri(uri, params), content_type)
    end

    def post(uri, data, params = {}, content_type = MIME_JSON)
      request("POST", generate_uri(uri, params), content_type, data)
    end

    def put(uri, data = nil, params = {}, content_type = MIME_JSON)
      request("PUT", generate_uri(uri, params), content_type, data)
    end

    def delete(uri, params = {}, content_type = MIME_JSON)
      request("DELETE", generate_uri(uri, params), content_type)
    end

    def api_base_uri
      @api_base_uri ||= URI.parse(API_BASE_URL)
    end

    def request(method, uri, content_type, data = {})
      #data.merge!({sandbox_mode: sandbox_mode})
      api_result = @http.send_request(method, uri, data.to_json, headers(content_type))
      puts uri
      # puts api_result.body
      {
        status: api_result.code,
        response: JSON.parse(api_result.body)
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
