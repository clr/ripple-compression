require 'helper'

class TestRipple < Test::Unit::TestCase
  def test_read_ripple_document
    assert doc = TestDocument.find('some_other_data')
    assert_equal 'this is secret data', doc.message
  end

  def test_write_ripple_document
    document = TestDocument.new
    document.message = 'here is some new data'
    document.save
    same_document = TestDocument.find(document.key)
    assert_equal document.message, same_document.message
  end

  def test_write_ripple_document_raw_confirmatio
    document = TestDocument.new
    document.message = 'here is some new data'
    document.save
    expected_doc_data = '{"version":"0.1.0","data":"eAGrVspNLS5OTE9VslLKSC1KVcgsVijOz01VyEstV0hJLElU0lGKL6ksAMmH\npBaXuOQnl+am5pUo1QIATJgUJg==\n"}'
    raw_data = `curl -s -XGET http://#{Ripple.config[:host]}:#{Ripple.config[:http_port]}/buckets/#{TestDocument.bucket_name}/keys/#{document.key}`
    assert_equal expected_doc_data, raw_data
  end
end
