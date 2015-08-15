module CDependencies
  class FileUnsupportedError < StandardError
  end

  class CompilerInvocation
    attr_accessor :tool_name
    attr_accessor :flags
    attr_accessor :input_path
    attr_accessor :output_file
    attr_accessor :output_path

    EXTENSION_MAP = { '.c' => 'cc',
                      '.cc'=> 'c++',
                      '.cpp' => 'c++',
                      '.hpp' => 'c++',
                      '.S' => 'gas',
                      '.asm' => 'nasm' }

    def initialize(path)
      self.input_path = path

      if self.tool_name.nil?
        raise FileUnsupportedError.new("Unsure how to compile a file with extension '#{self.input_extension}'")
      end
    end

    def input_extension
      File.extname(input_path)
    end

    def tool_name
      EXTENSION_MAP[input_extension]
    end

    def dependency_cmd
      "#{tool_cmd} #{dependency_flag} '#{input_path}'"
    end

    def has_flags?
      !flags.nil? && flags != ''
    end

    private
    def tool_cmd
      has_flags? ? "#{tool_name} #{flags}" : tool_name
    end

    def dependency_flag
      case tool_name
      when 'cc', 'c++'
        # -MM suppresses system header dependencies
        '-MM'
      when 'nasm'
        '-M'
      end
    end
  end
end
