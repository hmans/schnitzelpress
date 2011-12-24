module Schreihals
  class Cli
    def self.usage(exitcode=1)
      puts <<EOF
USAGE: #{File.basename($0)} [GLOBAL OPTIONS] <command> [COMMAND OPTIONS]

GLOBAL OPTIONS
    --help, -h            Display this message.
    --version, -v         Display version number.

COMMANDS
    create <path>         Create a new Schreihals blog.

OPTIONS FOR create
    --git                 Create a new git repository for the project.

EOF
      exit exitcode
    end

    def self.version
      puts "Schreihals #{Schreihals::VERSION}"
      exit 0
    end

    def self.parse_command_line
      opts = GetoptLong.new(
        ['--git', GetoptLong::NO_ARGUMENT],
        ['--help', '-h', GetoptLong::NO_ARGUMENT],
        ['--version', '-v', GetoptLong::NO_ARGUMENT],
      )
      options = {}
      opts.each do |opt, arg|
        case opt
        when '--help'
          usage(exitcode=0)
        when '--version'
          version
        else
          options[opt.sub(/^--/, '')] = arg
        end
      end
      options
    rescue GetoptLong::InvalidOption => e
      $stderr.puts
      usage
    end

    def self.main(options)
      command = ARGV.shift
      command.nil? && usage

      case command
      when 'create'
        # TODO: create new application here
      when 'post'
        # TODO: create new post here
      else
        raise "Unknown command: #{command}"
      end
    rescue RuntimeError => e
      $stderr.puts "ERROR: #{e}"
      exit 1
    end
  end
end
