module TinyRails
  module Paths
    class Root
      attr_accessor :path

      def initialize(path)
        @path = path
        @root = {}
      end

      def add(path, options = {})
        paths = Array(path)
        @root[path] = Path.new(self, path, paths, options)
      end

      def [](path)
        @root[path]
      end
    end

    class Path
      def initialize(root, current, paths, options)
        @root = root
        @current = current
        @paths = paths
        @options = options
      end

      def expanded
        results = @paths.map do |p|
          File.expand_path(p, @root.path)
        end
        results.uniq
      end

      def existent
        expanded.select { |f| File.exist?(f) }
      end
    end
  end
end