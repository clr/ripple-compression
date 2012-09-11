require 'helper'
require 'test_compression_rate'

class TestCompressionRateSlowly < TestCompressionRate
  def title
    "Compression [Optimized for Size]"
  end

  def setup
    better_compression_conf = File.expand_path(File.join('..','fixtures','ripple_better_compression.yml'),__FILE__)
    Ripple.load_configuration better_compression_conf, ['test']
    super
  end

  def teardown
    Ripple.load_configuration ENV['RIPPLE'], ['test']
  end
end
