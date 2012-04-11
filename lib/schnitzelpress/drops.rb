module Schnitzelpress
  module Drops
    class BlogDrop < Liquid::Drop
      def initialize(attrs)
        @attrs = attrs
      end

      def title
        @attrs[:title]
      end

      def footer
        @attrs[:footer]
      end

      def description
        @attrs[:description]
      end
    end
  end
end
