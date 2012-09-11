module Ripple
  module Compression
    # Implements the {Riak::Serializer} API for the purpose of
    # compressing/decompressing Ripple documents.
    #
    # Example usage:
    #     ::Riak::Serializers['application/x-json-compressed'] = Ripple::Compression::Serializer.new
    #     class MyDocument
    #       include Ripple::Document
    #       include Ripple::Compression
    #     end
    #
    # @see Compression
    class Serializer
      def initialize
      end

      # Serializes and compresses the Ruby object using the assigned
      # Content-Type.
      # @param [Object] object the Ruby object to serialize/compress
      # @return [String] the serialized, compressed form of the object
      def dump(object)
        JsonDocument.new(object).compress
      end

      # Decrypts and deserializes the blob using the assigned cipher
      # and Content-Type.
      # @param [String] blob the original content from Riak
      # @return [Object] the decompressed and deserialized object
      def load(object)
        CompressedJsonDocument.new(object).decompress
      end
    end
  end
end
