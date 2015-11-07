require 'digest'

module CDependencies
  class DependencyList
    attr_reader :paths

    def initialize(array)
      @paths = array.map { |x| File.absolute_path(x) }
    end

    def write_to_file(path)
      File.open(path, 'w+') do |file|
        file << serializable_entries.join("\n")
        file << "\n"
      end
    end

    def self.read_from_file(path)
      list = File.readlines(path)
      list.map! { |x| x.chomp() }

      # make a non-empty list of files
      list.reject! { |x| x.empty? }

      # [path, sha] throwing away the sha part for now
      list.map! { |x| x.split(',')[0] }

      # remove files that do not exist
      list.reject! { |x| !File.exist?(x) }

      DependencyList.new(list)
    end

    def append(path)
      @paths << File.absolute_path(path)
    end

    private
    def serializable_dependency_entry(entry)
      "#{entry}, #{file_hash(entry)}"
    end

    def serializable_entries
      paths.map { |x| serializable_dependency_entry(x) }
    end

    def file_hash(path)
      Digest::SHA1.file(path).hexdigest
    end
  end
end
