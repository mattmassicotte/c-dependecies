require "c-dependencies/version"
require 'c-dependencies/compiler_invocation'

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

    # first element is the object file, second is the source itself
    list = list[2..-1]

    list.reject { |x| x.empty? || x == '\\' } # remove blanks and line continuations
  end
end
