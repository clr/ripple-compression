require 'helper'

class TestDeflator < Test::Unit::TestCase
  setup do
    @deflator = Ripple::Compression::Compressor.new
    # example text
    @text      = "This is some nifty text and it's going to compress into some very small blob."
    # this is the example text compressed
    @blob      = "x\x01\x1D\xCAA\n\x800\f\x05\xD1\xAB\xFC\x9D;O\xE3\x05Z\x8D5\x90&\xD2\x04\xB1\xB77\b\xB3\x19x\xDB\xC5\x8E\xCC\xAD\x13\x94\xCF\x98\bz\x03E\x0Fp,\x8Ef\xAC\ra\xD8\xAD\xDF\x83<\xB5\xE6\xFD\xFE\xA11\xE1\xBD\x88\xA0\x8A\xD5\xF5\x03A)\e\xFF"
  end

  def test_deflation_of_blob
    assert_equal @blob, @deflator.deflate(@text), "Compression failed."
  end

  def test_inflation_of_blob
    assert_equal @text, @deflator.inflate(@blob), "Decompression failed."
  end
end
