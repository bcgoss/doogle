require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe :lookup do
    before(:each) do
      allow(DictionaryService).to receive(:lookup)
    end

    it 'looks up existing words' do
      word = create :entry, word: 'word'
      definition = create :definition, text: 'something that is said'
      word.definitions << definition

      expect(DictionaryService).to_not receive(:lookup)

      subject = Entry.lookup(word: 'Word')

      expect(subject.word).to eq 'word'
      expect(subject.definitions).to include(definition)
    end

    it 'uses the API for missing words' do
      expect(DictionaryService).to receive(:lookup).with('word')
      Entry.lookup(word: 'word')
    end
  end

  describe :create_from_dictionary do
    it 'returns a new entry for a valid dictionary' do
      expect do
        @subject = Entry.create_from_dictionary({word: 'word', definitions: ['something that is said', 'the text of a vocal musical composition']})
      end.to change { Entry.count }.by 1

      expect(@subject.word).to eq 'word'
      expect(@subject.definitions.first.text).to eq 'something that is said'
    end

    it 'returns a Null Entry for non-words' do
      subject = Entry.create_from_dictionary(nil)
      expect(subject.word).to eq 'Invalid word'
      expect(subject.definitions.first.text).to eq 'No definition found'
    end
  end
  describe 'validations' do
    it { should have_many :definitions }
    it { should validate_presence_of(:word) }
    it { should validate_uniqueness_of(:word).ignoring_case_sensitivity }

    it 'converts to lowercase words' do
      subject = Entry.create(word: 'Word')
      expect(subject.word).to eq 'word'
    end
  end

  describe Entry::NullEntry do
    it 'has the error text' do
      subject = Entry::NullEntry.new
      expect(subject.word).to eq 'Invalid word'
    end

    it 'is associated with a NullDefinition' do
      definition = subject.definitions.first
      expect(definition).to be_a Definition
      expect(definition.text).to eq 'No definition found'
    end
  end
end
