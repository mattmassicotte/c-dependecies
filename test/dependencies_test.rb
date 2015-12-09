require 'test_helper'

class CDependenciesTest < Minitest::Test

  def test_file_that_has_no_dependencies
    deps = CDependencies.for_source_file('test/data/no_dependencies.c')
    assert_equal [], deps.paths
  end

  def test_file_that_has_local_header_dependencies
    deps = CDependencies.for_source_file('test/data/local_header_dependencies.c')
    paths = deps.paths.map { |x| File.basename(x) }.sort

    assert_equal ['header1.h', 'header2.h'], paths
  end

  def test_file_that_has_transitive_header_dependencies
    deps = CDependencies.for_source_file('test/data/transitive_header_dependencies.c')
    paths = deps.paths.map { |x| File.basename(x) }.sort

    assert_equal ['header1.h', 'header2.h', 'header3.h'], paths
  end

end
