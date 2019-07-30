
require 'claide'
require 'rubygems'
require 'colored2'


module Gitl
  class Error < StandardError; end

  class Command < CLAide::Command

    require 'commands/init'

    self.abstract_command = true
    self.command = 'gitl'
    self.version = VERSION
    self.description = 'Gitl, the tianxiao gitlab manager.'

    def self.run(argv)
      help! 'You cannot run gitl as root.' if Process.uid == 0 && !Gem.win_platform?

      super(argv)
    end

    def self.report_error(exception)
      case exception
      when Interrupt
        puts '[!] Cancelled'.red
        self.verbose? ? raise : exit(1)
      when SystemExit
        raise
      else
        raise exception
      end
    end

  end

end