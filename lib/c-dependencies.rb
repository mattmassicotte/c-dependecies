require "c-dependencies/version"
require 'c-dependencies/compiler_invocation'
require 'c-dependencies/dependency_list'

module CDependencies
  def self.for_source_file(path, flags=nil)
    invocation = CompilerInvocation.new(path, flags)

    cmd = invocation.dependency_cmd

    # consult rake's verbose function, if defined
    if defined? verbose
      puts(cmd) if verbose()
    end

    output = `#{cmd}`.chomp()
    list = output.split()
    raise("unexpected dependency output for '#{path}'") if list.size < 2

    # remove blanks and line continuations, which can come up as a side-effect
    # of the split
    list.reject! { |x| x.empty? || x == '\\' }

    # first element is the object file, second is the source itself
    list = list[2..-1]

    DependencyList.new(list)
  end
end
