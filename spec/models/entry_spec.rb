require 'rails_helper'

RSpec.describe Entry, type: :model do
  it 'looks up existing words' do
    # definition = create :definition, text: 'something that is said'
    word = create :entry, word: 'word' #, defintion: definition

    expect(Entry.lookup(word: 'Word')).to eq word
  end

  it 'returns a new entry for a valid dictionary' do
    subject = Entry.create_from_dictionary({word: 'word', definitions: ['something that is said', 'the text of a vocal musical composition']})
    expect(subject.word).to eq 'word'
    expect(subject.definitions.first.text).to eq 'something that is said'
  end

  it 'returns a Null Entry for non-words' do
    subject = Entry.create_from_dictionary(nil)
    expect(subject.word).to eq 'Invalid word'
    expect(subject.definitions.first.text).to eq 'Word not found'
  end

  it 'uses the API for missing words' do
    expect(Entry.lookup(word: 'Word').word).to eq 'word'
  end
end
