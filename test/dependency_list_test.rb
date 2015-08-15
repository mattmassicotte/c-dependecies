require 'test_helper'
require 'tempfile'

class DependencyListTest < Minitest::Test
  def test_serialize_dependencies
    file_path = Tempfile.new('deps').path

    deplist = CDependencies::DependencyList.new(['test/data/header1.h', 'test/data/header2.h'])

    deplist.write_to_file(file_path)

    read_deplist = CDependencies::DependencyList.read_from_file(file_path)

    assert_equal deplist.paths, read_deplist.paths
  end
end
