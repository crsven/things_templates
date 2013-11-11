require 'yaml'

class Template
  attr_reader :items, :project

  def initialize(file)
    yaml = YAML.load(File.open(file))
    @items = yaml['items']
    @project = yaml.fetch('project', nil)
  end

  def build!
    ThingsController.add_project(project, items) if project
    items.each do |item|
      ThingsController.add_item(item)
    end
  end
end
