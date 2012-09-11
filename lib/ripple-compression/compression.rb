module Ripple
  # When mixed into a Ripple::Document class, this will compress the
  # serialized form before it is stored in Riak.  You must register
  # a serializer that will perform the compression.
  # @see Serializer
  module Compression
    # Overrides the internal method to set the content-type to be
    # compressed.
    def robject
      @robject ||= Riak::RObject.new(self.class.bucket, key).tap do |obj|
        obj.content_type = 'application/x-json-compressed'
      end
    end
    def update_robject
      robject.key = key if robject.key != key
      robject.content_type ||= 'application/x-json-compressed'
      robject.data = attributes_for_persistence
    end
  end
end
