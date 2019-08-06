
module Gitl
  class WorkSpaceConfig
    attr_reader :remote_branch
    attr_reader :workspace_branch

    def initialize(remote_branch, workspace_branch)
      @remote_branch = remote_branch
      @workspace_branch = workspace_branch
    end

    def self.load_file(yaml_filename)
      node = YAML.load_file(yaml_filename)
      remote_branch = node['remote_branch']
      workspace_branch = node['remote_branch']
      return WorkSpaceConfig.new(remote_branch, workspace_branch)
    end

    def save(path)
      File.open(path, 'w') do |file|
        file.write(self.to_yaml)
      end
    end
  end
end