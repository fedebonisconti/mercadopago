module Mercadopago
  class Response
    attr_reader :status, :response, :content

    def initialize(status, response)
      @status = status
      @response = response
    end

    def [](attr)
      content[attr]
    end

    def to_h
      content
    end

    def method_missing(name, *args, &block)
      if response.has_key?(name) || response.has_key?(name.to_s)
        response[name] || response[name.to_s]
      else
        super
      end
    end

    def respond_to?(name, include_private = false)
      response.has_key?(name.to_sym) || response.has_key?(name.to_s) || super
    end

    def content
      @content ||= {status: status, response: response}
    end
  end
end
