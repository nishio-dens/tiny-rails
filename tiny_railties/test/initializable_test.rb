require "minitest/autorun"
require "tiny_rails/initializable"

module InitializableTests
  class NodeA
    include TinyRails::Initializable

    initializer :boot do
      $nodes ||= []
      $nodes << :boot
    end

    initializer :hello_initializers do
      $nodes ||= []
      $nodes << :hello_initializers
    end

    initializer :before_hello_initializer, before: :hello_initializers do
      $nodes ||= []
      $nodes << :before_hello_initializer
    end
  end

  class NodeB < NodeA
    include TinyRails::Initializable

    initializer :another_before_hello_initializer, before: :hello_initializers do
      $nodes ||= []
      $nodes << :another_before_hello_initializer
    end

    initializer :something, after: :boot do
      $node ||= []
      $nodes << :something
    end
  end

  class Basic < MiniTest::Test
    def test_run_basic_initializer
      $nodes = []

      node_a = NodeA.new
      node_a.run_initializers

      expected = %i[boot before_hello_initializer hello_initializers]
      assert_equal expected, $nodes
    end

    def test_run_inherited_initializer
      $nodes = []

      node_b = NodeB.new
      node_b.run_initializers

      expected = %i[boot before_hello_initializer another_before_hello_initializer hello_initializers something]
      assert_equal expected, $nodes
    end
  end
end
