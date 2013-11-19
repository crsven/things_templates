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
    let(:new_project) { 'new project' }

    subject { ThingsController.add_project new_project }

    before { ThingsController.stub(:system) }

    context 'given the project does not exist' do
      before { ThingsController.stub(:project_exists?).and_return(false) }
      before { subject }

      it 'creates the project' do
        expect(ThingsController).to have_received(:system)
          .with(/.*#{new_project}.*/)
      end
    end

    context 'given the project already exists' do
      before { ThingsController.stub(:project_exists?).and_return(true) }

      it 'does not create the project' do
        expect(ThingsController).to_not have_received(:system)
      end
    end
  end

  describe '.add_items_to_project' do
    let(:new_item)    { 'new item' }
    let(:new_project) { 'new project' }
    let(:tags)        { nil }

    subject { ThingsController.add_items_to_project(new_project, [new_item], tags) }

    before { ThingsController.stub(:system) }

    context 'given the project exists' do
      before { ThingsController.stub(:project_exists?).and_return(true) }
      before { subject }

      it 'calls the add script with the item and project' do
        expect(ThingsController).to have_received(:system)
          .with(/.*#{new_item}.*#{new_project}.*/)
      end

      context 'given tags' do
        let(:tags) { ['best', 'ever'] }

        it 'calls the add script with the item, project and tags' do
          expect(ThingsController).to have_received(:system)
            .with(/.*#{new_item}.*#{new_project}.*#{tags.join(', ')}.*/)
        end
      end
    end

    context 'given the project does not exist' do
      before { ThingsController.stub(:project_exists?).and_return(false) }

      it 'creates the project and item' do
        expect(ThingsController).to receive(:system)
          .with(/.*#{new_project}.*/).ordered

        expect(ThingsController).to receive(:system)
          .with(/.*#{new_item}.*#{new_project}.*/).ordered

        subject
      end
    end
  end
end
