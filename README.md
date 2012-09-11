# Ripple::Compression

The ripple-compression gem provides compression and decryption for Ripple documents.
[riak-ruby](https://github.com/basho/riak-ruby-client) [ripple](https://github.com/seancribbs/ripple)


## Installation

Add this line to your application's Gemfile:

    gem 'ripple-compression'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ripple-compression

## Overview

Compression levels vary greatly, but overall JSON seems to compress
well.  The larger the files I included in the tests, the better the
compression rate.  In the test files included, the size difference
varied from -12.5% on a 232B file (it grew 29B) to 82.3% on a 85KB file
(deflated to 15KB).  The average file space saved in the 12 included
tests is 77.5%, which you can see by running the tests. Turning up the 
compression level seemed to provide little benefit, but results will 
vary greatly.

You call the activation, which initializes a global serializer within
Ripple.  Any object that gets saved with content-type 'application/x-json-compressed'
then goes through the Compression::Serializer, which loads or unloads the
data from Riak through the JsonDocument and CompressedJsonDocument,
respectively.  Both of these have a dependency on Compression::Compressor,
which makes the actual calls to OpenSSL.

JsonDocument stores the compressed data wrapped in JSON encapsulation so
that you can still introspect the Riak object and see which version of
this gem was used to compress it.

There is also a Rake file to convert between compressed and decompressed
JSON objects. Try:

    bundle exec rake migrate:compress

or

    bundle exec rake migrate:decompress

The CPU time to compress seems trivial. We rely on the native Ruby implementation
of zlib.

## Usage

Include the gem in your Gemfile.  Activate it somewhere in your
application initialization.

    Ripple::Compression::Activation.new

Then include the Ripple::Compression module in your document class:

    class SomeDocument
      include Ripple::Document
      include Ripple::Compression
      property :message, String
    end

These 'SomeDocument' documents will now be stored compressed.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
