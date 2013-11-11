require 'yaml'

class Template
  attr_reader :items, :project

  def initialize(file)
    yaml = YAML.load(File.open(file))
    @items = yaml['items']
    @project = yaml.fetch('project', nil)
  end

  def build!
    if project
      ThingsController.add_items_to_project(project, items)
    else
      items.each do |item|
        ThingsController.add_item(item)
      end
    end
  end
end
