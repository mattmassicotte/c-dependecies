module CDependencies
  class FileUnsupportedError < StandardError
  end

  class CompilerInvocation
    attr_accessor :tool_name
    attr_accessor :flags
    attr_accessor :input_path
    attr_accessor :output_path

    EXTENSION_MAP = { '.c' => 'cc',
                      '.h' => 'cc',
                      '.cc'=> 'c++',
                      '.cpp' => 'c++',
                      '.hpp' => 'c++',
                      '.S' => 'gas',
                      '.asm' => 'nasm' }

    def initialize(path, compiler_flags=nil)
      self.input_path = path
      self.flags = compiler_flags

      if tool_name.nil?
        raise FileUnsupportedError.new("Unsure how to compile a file with extension '#{input_extension}'")
      end
    end

    def input_extension
      File.extname(input_path)
    end

    def tool_name
      name = default_tool_name

      case name
      when 'c++'
        get_env_named('CXX') || name
      when 'cc'
        get_env_named('CC') || name
      else
        name
      end
    end

    def default_tool_name
      EXTENSION_MAP[input_extension]
    end

    def dependency_cmd
      "#{tool_cmd} #{dependency_flag} '#{input_path}'"
    end

    def compile_cmd
      cmd = tool_cmd
      cmd += " -c '#{input_path}'"
      cmd += " -o '#{output_path}'"
      cmd
    end

    private
    def tool_cmd
      cmd = tool_name
      cmd += ' ' + flags if !flags.nil? && flags != ''
      cmd
    end

    def dependency_flag
      case default_tool_name
      when 'cc', 'c++'
        # -MM suppresses system header dependencies
        '-MM'
      when 'nasm'
        '-M'
      end
    end

    private
    def get_env_named(name)
      env_var = ENV[name]

      if env_var.nil? || env_var == ''
        nil
      else
        env_var
      end
    end
  end
end
