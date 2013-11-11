require 'spec_helper'

describe Template do
  let(:file_path) { 'spec/files/test_template.yml' }

  subject { Template.new file_path }

  describe '.initialize' do
    let(:items) { ['test_item_1', 'test_item_2'] }

    it 'loads the given file' do
      expect(subject.items).to eq items
    end
  end

  describe '#build' do
    before { ThingsController.stub(:add_item) }
    before { subject.build! }

    context 'with an item list template' do
      it 'adds a Things item for each item' do
        expect(ThingsController).to have_received(:add_item).with('test_item_1')
        expect(ThingsController).to have_received(:add_item).with('test_item_2')
      end
    end

    context 'with a project list template' do
      let(:file_path) { 'spec/files/test_template_with_project.yml' }

      before { ThingsController.stub(:add_project) }

      it 'creates a project' do
        expect(ThingsController).to have_received(:add_project).with('test_project', ['test_item_1', 'test_item_2'])
      end

      it 'adds a Things item for each item' do
        expect(ThingsController).to have_received(:add_item).with('test_item_1')
        expect(ThingsController).to have_received(:add_item).with('test_item_2')
      end
    end
  end
end
