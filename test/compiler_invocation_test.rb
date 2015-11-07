require 'test_helper'

class CompilerInvocationTest < Minitest::Test
  def test_c_file_input
    invocation = CDependencies::CompilerInvocation.new('file.c')
    assert_equal 'cc', invocation.tool_name
  end

  def test_cc_file_input
    invocation = CDependencies::CompilerInvocation.new('file.cc')
    assert_equal 'c++', invocation.tool_name
  end

  def test_cpp_file_input
    invocation = CDependencies::CompilerInvocation.new('file.cpp')
    assert_equal 'c++', invocation.tool_name
  end

  def test_hpp_file_input
    invocation = CDependencies::CompilerInvocation.new('file.hpp')
    assert_equal 'c++', invocation.tool_name
  end

  def test_S_file_input
    invocation = CDependencies::CompilerInvocation.new('file.S')
    assert_equal 'gas', invocation.tool_name
  end

  def test_asm_file_input
    invocation = CDependencies::CompilerInvocation.new('file.asm')
    assert_equal 'nasm', invocation.tool_name
  end

  def test_c_dependency_command
    invocation = CDependencies::CompilerInvocation.new('file.c')
    invocation.flags = '-Wall'

    assert_equal 'cc -Wall -MM \'file.c\'', invocation.dependency_cmd
  end

  def test_asm_dependency_command
    invocation = CDependencies::CompilerInvocation.new('file.asm')

    assert_equal 'nasm -M \'file.asm\'', invocation.dependency_cmd
  end

  def test_compile_command
    invocation = CDependencies::CompilerInvocation.new('file.c')
    invocation.flags = '-Wall'
    invocation.output_path = 'file.o'

    assert_equal 'cc -Wall -c \'file.c\' -o \'file.o\'', invocation.compile_cmd
  end
end
