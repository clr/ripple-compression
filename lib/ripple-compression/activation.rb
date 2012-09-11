module Ripple
  module Compression
    class Activation
      def initialize
        # short-circuit compression via the ripple.yml config file if desired
        if !Riak::Serializers['application/x-json-compressed'] && (Ripple.config[:compression] != false)
          Riak::Serializers['application/x-json-compressed'] = Ripple::Compression::Serializer.new
        end
      end
    end
  end
end
