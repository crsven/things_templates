require 'yaml'

class ThingsTemplates::Template
  attr_reader :items, :project, :tags

  def initialize(file)
    yaml = YAML.load(File.open(file))
    @items = yaml['items']
    @project = yaml.fetch('project', nil)
    @tags = yaml.fetch('tags', nil)
  end

  def build!
    if project
      ThingsTemplates::AppController.add_items_to_project(project, items, tags)
    else
      items.each do |item|
        ThingsTemplates::AppController.add_item(item)
      end
    end
  end
end
