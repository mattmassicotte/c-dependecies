require "c-dependencies/version"
require 'c-dependencies/compiler_invocation'

module CDependencies
  C_SOURCE = :c
  CPP_SOURCE = :cpp
  ASM_SOURCE = :asm
  S_SOURCE = :s
  PCH_SOURCE = :pch
  SOURCE_TYPES = [C_SOURCE, CPP_SOURCE, ASM_SOURCE, S_SOURCE, PCH_SOURCE]

  def self.compiler_for_source(source, flags=nil)
    cpp_flags = cc_flags = flags

    if flags.is_a? Hash
      cpp_flags = flags[:cpp_flags]
      cc_flags = flags[:cc_flags]
    end

    case File.extname(source)
    when '.cpp', '.cc', '.hpp'
      "c++ #{cpp_flags}"
    when ".c", ".h"
      "cc #{cc_flags}"
    else
      raise("Don't know how to compile #{source}")
    end
  end


  def self.dependencies_for_source_file(path, flags)
  end
end
