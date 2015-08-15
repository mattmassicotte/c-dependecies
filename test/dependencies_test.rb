require 'test_helper'

class CDependenciesTest < Minitest::Test
  def test_file_that_has_no_dependencies
    deps = CDependencies.for_source_file('test/data/no_dependencies.c')
    assert_equal [], deps
  end

  def test_file_that_has_local_header_dependencies
    deps = CDependencies.for_source_file('test/data/local_header_dependencies.c')
    assert_equal ['test/data/header1.h', 'test/data/header2.h'], deps
  end
end
