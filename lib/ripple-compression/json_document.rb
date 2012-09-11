module Ripple
  module Compression
    # Implements an encapsulation in JSON for compressed Ripple documents.
    #
    # Example usage:
    #     Ripple::Compression::JsonDocument.new(@document).compress
    class JsonDocument
      # Creates an object that is prepared to compress its contents.
      # @param [String] data object to store
      def initialize(data)
        @data = JSON.dump(data)
        @compressor = Ripple::Compression::Compressor.new
      end

      # Converts the data into the compressed format
      def compress
        compressed_data = @compressor.deflate @data
        JSON.dump({:version => Ripple::Compression::VERSION, :data => Base64.encode64(compressed_data)})
      end
    end
  end
end
