require 'test_helper'

class CompilerInvocationTest < Minitest::Test
  def test_c_file_input
    invocation = CDependencies::CompilerInvocation.new('file.c')
    assert invocation.tool_name == 'cc'
  end

  def test_cc_file_input
    invocation = CDependencies::CompilerInvocation.new('file.cc')
    assert invocation.tool_name == 'c++'
  end

  def test_cpp_file_input
    invocation = CDependencies::CompilerInvocation.new('file.cpp')
    assert invocation.tool_name == 'c++'
  end

  def test_hpp_file_input
    invocation = CDependencies::CompilerInvocation.new('file.hpp')
    assert invocation.tool_name == 'c++'
  end

  def test_S_file_input
    invocation = CDependencies::CompilerInvocation.new('file.S')
    assert invocation.tool_name == 'gas'
  end

  def test_asm_file_input
    invocation = CDependencies::CompilerInvocation.new('file.asm')
    assert invocation.tool_name == 'nasm'
  end

  def test_simple_c_dependency_command
    invocation = CDependencies::CompilerInvocation.new('file.c')
    invocation.flags = '-Wall'

    assert invocation.dependency_cmd == 'cc -Wall -MM \'file.c\''
  end
end
