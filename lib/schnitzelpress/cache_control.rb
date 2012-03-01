module Schnitzelpress
  module CacheControl
    class << self
      def timestamp
        Schnitzelpress::Config.get 'cache_timestamp'
      end

      def bust!
        Schnitzelpress::Config.set 'cache_timestamp', Time.now
      end

      def etag(*args)
        Digest::MD5.hexdigest("-#{timestamp.to_i}-#{args.join '-'}-")
      end
    end
  end
end
