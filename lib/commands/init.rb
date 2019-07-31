require 'command'
require 'yaml'
require 'config/yml_config'
require 'colored2'

module Gitl

  class Init < Command

    self.summary = '根据yml配置，更新代码'

    self.description = <<-DESC
      根据yml配置，更新代码.
    DESC

    self.arguments = [
        CLAide::Argument.new('yml', false, false),
    ]

    def initialize(argv)
      @yml = argv.shift_argument
      if @yml.nil?
        @yml = 'Gitl.yml'
      end
      super
    end

    def validate!
      super
      if @yml.nil?
        help! 'manifest is required.'
      end
    end

    def run
      config = YmlConfig.load_file(@yml)
      config.projects.each do |project|
        project_path = File.expand_path(project.name, './')
        if File.exist?(project_path)
          puts project.name + ' exists, skip.'
        else
          g = Git.clone(project.git, project.name, :path => './', :depth => 1)
        end

      end
    end
  end

end