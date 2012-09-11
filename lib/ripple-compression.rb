require 'openssl'
require 'ripple'

module Ripple
  module Compression
  end
end

# Include all of the support files.
Dir[File.expand_path(File.join('..','ripple-compression','*.rb'),__FILE__)].each{|f| require f}
