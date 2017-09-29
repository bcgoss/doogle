require 'rails_helper'

RSpec.describe Definition, type: :model do
  it { should have_many :entries }

  describe Definition::NullDefinition do
    it 'contains missing definition text' do
      subject = Definition::NullDefinition.new
      expect(subject.text).to eq 'No definition found'
    end

    it 'is associated with a NullEntry' do
      entry = subject.entries.first
      expect(entry).to be_an Entry
      expect(entry.word).to eq 'Invalid word'
    end
  end
end