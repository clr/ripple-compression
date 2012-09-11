require 'helper'

class TestUncompressedDocument < Test::Unit::TestCase
  def test_read_uncompressed_document_too
    assert (doc = TestDocument.find('some_data')), "Could not find fixture."
    assert_equal 'this is uncompressed data', doc.message
  end

  def test_write_uncompressed_document_when_content_type_is_plain
    document = TestDocument.new
    document.message = 'here is some new data'
    document.robject.content_type = 'application/json'
    document.save
    expected_doc_data = '{"message":"here is some new data","_type":"TestDocument"}'
    raw_data = `curl -s -XGET http://#{Ripple.config[:host]}:#{Ripple.config[:http_port]}/buckets/#{TestDocument.bucket_name}/keys/#{document.key}`
    assert_equal expected_doc_data, raw_data
  end
end
