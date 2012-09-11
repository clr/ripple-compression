require 'helper'

class TestJsonDocument < Test::Unit::TestCase
  setup do
    # get some compression going
    compressor = Ripple::Compression::Compressor.new

    # this is the data package that we want
    @document = {'some' => 'data goes here'}

    # this is how we want that data package to actually be stored
    compressed_value = compressor.deflate JSON.dump @document
    @compressed_document = JSON.dump({:version => Ripple::Compression::VERSION, :data => Base64.encode64(compressed_value)})
  end

  def test_convert_document_to_desired_JSON
    assert_equal @compressed_document, Ripple::Compression::JsonDocument.new(@document).compress, 'Did not get the JSON format expected.'
  end

  def test_interpret_JSON_into_document
    assert_equal @document, Ripple::Compression::CompressedJsonDocument.new(@compressed_document).decompress, 'Did not get the JSON format expected.'
  end
end
