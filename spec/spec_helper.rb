$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mercadopago'
require 'webmock/rspec'

MERCADOPAGO_API = 'https://api.mercadopago.com'.freeze
