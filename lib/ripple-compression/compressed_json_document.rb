module Ripple
  module Compression
    # Generic error class for compressor
    class CompressedJsonDocumentError < StandardError; end

    # Interprets a encapsulation in JSON for compressed Ripple documents.
    #
    # Example usage:
    #     Ripple::Compression::JsonDocument.new(@document).compress
    #     Ripple::Compression::CompressedJsonDocument.new(@document).decompress
    class CompressedJsonDocument
      # Creates an object that is prepared to decrypt its contents.
      # @param [String] data json string that was stored in Riak
      def initialize(data)
        @json = JSON.parse data
        @compressor = Ripple::Compression::Compressor.new
      end

      # Returns the original data from the stored compressed format
      def decompress
        JSON.load @compressor.inflate Base64.decode64 @json['data']
      end
    end
  end
end
