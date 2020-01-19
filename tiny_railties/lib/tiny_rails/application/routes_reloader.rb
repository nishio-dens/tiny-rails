module TinyRails
  class Application
    class RoutesReloader
      attr_reader :route_sets, :paths

      def initialize
        @route_sets = []
        @paths = []
      end

      def reload!
        load_paths
      end

      def execute
        # 実際のRailsではファイルの更新を確認し、変更があれば再読み込みをかける
        # TinyRailsの現バージョンでは単にreloadを呼ぶだけとする

        reload!
      end

      private

      def load_paths
        paths.each { |path| load(path) }
      end
    end
  end
end