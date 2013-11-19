require 'spec_helper'

describe ThingsTemplates::Template do
  let(:file_path) { 'spec/files/test_template.yml' }

  subject { ThingsTemplates::Template.new file_path }

  describe '.initialize' do
    let(:items) { ['test_item_1', 'test_item_2'] }

    it 'loads the given file' do
      expect(subject.items).to eq items
    end
  end

  describe '#build' do
    before { ThingsTemplates::AppController.stub(:add_item) }

    context 'with an item list template' do
      before { subject.build! }

      it 'adds a Things item for each item' do
        expect(ThingsTemplates::AppController).to have_received(:add_item).with('test_item_1')
        expect(ThingsTemplates::AppController).to have_received(:add_item).with('test_item_2')
      end
    end

    context 'with a project list template with tags' do
      let(:file_path) { 'spec/files/test_template_with_project.yml' }

      before { ThingsTemplates::AppController.stub(:add_items_to_project) }
      before { subject.build! }

      it 'creates a project' do
        expect(ThingsTemplates::AppController).to have_received(:add_items_to_project)
          .with('test_project', ['test_item_1', 'test_item_2'], ['tag_1', 'tag_2'])
      end

      it 'adds a Things item for each item' do
        expect(ThingsTemplates::AppController).to_not have_received(:add_item)
      end
    end
  end
end
