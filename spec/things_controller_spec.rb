require 'spec_helper'

describe ThingsController do
  describe '.add_item' do
    let(:new_item) { 'new item' }
    before { ThingsController.stub(:system) }
    before { ThingsController.add_item(new_item) }

    it 'calls the add script with the item' do
      expect(ThingsController).to have_received(:system)
        .with(/.*#{new_item}.*/)
    end
  end

  describe '.add_project' do
    let(:new_item)    { 'new item' }
    let(:new_project) { 'new project' }
    before { ThingsController.stub(:system) }
    before { ThingsController.add_project(new_project, [new_item]) }

    it 'calls the add script with the item and project' do
      expect(ThingsController).to have_received(:system)
        .with(/.*name:\"#{new_project}.*#{new_item}.*#{new_project}.*/)
        #.with(/.*make new ,roject.*#{new_project}.*make new to do.*#{new_item}.*at beginning of project.*#{new_project}.*/)
    end
  end
end
