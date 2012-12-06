require "savon/operation"
require "savon/options"
require "wasabi"

module Savon
  class NewClient

    def initialize(wsdl_locator, options = {})
      @wsdl = Wasabi::Document.new(wsdl_locator)

      @options = Options.new
      @options.set(:global, options)
    end

    def operations
      @wsdl.soap_actions
    end

    def operation(operation_name)
      Operation.create(operation_name, @wsdl, @options)
    end

    def call(operation_name, options = {})
      response = operation(operation_name).call(options)
      @options.add(:global, :last_response, response.http)
      response
    end

  end
end
