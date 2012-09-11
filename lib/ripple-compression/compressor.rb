module Ripple
  module Compression
    # Generic error class for Deflator
    class CompressorError < StandardError; end

    # Implements a simple object that can either compress or decompress arbitrary data.
    #
    # Example usage:
    #     deflator = Ripple::Compression::Compressor.ne
    #     deflator.deflate stuff
    #     deflator.inflate stuff
    class Compressor
      # Creates an Deflator that is prepared to deflate/inflate a blob.
      # @param [Hash] config the key/cipher/iv needed to initialize OpenSSL
      def initialize
        @compression_level = Ripple.config[:compression_level] || Zlib::BEST_SPEED
      end

      # Compress stuff.
      # @param [Object] blob the data to compress
      def deflate(blob)
        Zlib::Deflate.deflate blob, @compression_level
      end

      # Decompress stuff.
      # @param [Object] blob the compressed data to decompress
      def inflate(blob)
        Zlib::Inflate.inflate blob
      end
    end
  end
end
