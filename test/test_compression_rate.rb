require 'helper'

class TestCompressionRate < Test::Unit::TestCase
  def title
    "Compression [Optimized for Speed]"
  end

  def setup
    # created compressed versions of all of the sample files
    Dir[File.expand_path(File.join('..','fixtures','sample_*.json'),__FILE__)].each do |f|
      text = File.read(f)
      json = JSON.parse text
      File.open("#{f.gsub(/.json/,'')}.compressed",'w'){|f| f.write(Ripple::Compression::JsonDocument.new(json).compress)}
    end
  end

  def test_time_to_write_samples
    uncompressed = []
    compressed   = []
    Dir[File.expand_path(File.join('..','fixtures','*.json'),__FILE__)].each do |f|
      key = File.basename(f,'.json')
      start_time = Time.now
      `curl -s -H 'content-type: application/json' -XPUT http://#{Ripple.config[:host]}:#{Ripple.config[:http_port]}/buckets/#{Ripple.config[:namespace]}_uncompressed_json/keys/#{key} --data-binary @#{f}`
      uncompressed << Time.now - start_time
      key = File.basename(f,'.compressed')
      start_time = Time.now
      `curl -s -H 'content-type: application/x-json-compressed' -XPUT http://#{Ripple.config[:host]}:#{Ripple.config[:http_port]}/buckets/#{Ripple.config[:namespace]}_compressed_json/keys/#{key} --data-binary @#{f}`
      compressed << Time.now - start_time
    end
    puts ''
    puts "#{title} Time:"
    uncompressed.each_with_index do |value, i|
      puts "  #{((value - compressed[i]).to_f / value * 100).round(1)}% time delta."
    end
    delta = (uncompressed.sum - compressed.sum).to_f
    puts "Total: #{(delta / uncompressed.sum * 100).round(1)}% time delta, difference of #{delta.round(5)} seconds."
  end

  def test_compression_size
    uncompressed = []
    compressed   = []
    Dir[File.expand_path(File.join('..','fixtures','*.json'),__FILE__)].each do |f|
      uncompressed << File.size(f)
      compressed << File.size(f.gsub(/.json/,'.compressed'))
    end
    puts ''
    puts "#{title} File Size:"
    uncompressed.each_with_index do |value, i|
      puts "  #{((value - compressed[i]).to_f / value * 100).round(1)}% deflated."
    end
    puts "Total: #{((uncompressed.sum - compressed.sum).to_f / uncompressed.sum * 100).round(1)}% deflated."
  end
end
