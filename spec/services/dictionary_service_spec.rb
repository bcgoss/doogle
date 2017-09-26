require 'rails_helper'

RSpec.describe 'DictionaryService' do
  it 'looks up valid words' do
    subject = DictionaryService.lookup('word')
    expect(subject[:word]).to eq 'word'
    expect(subject[:definitions].first).to eq 'something that is said'
  end

  it 'returns nil for invalid words' do
    subject = DictionaryService.lookup('asfdasdfasdf')
    expect(subject).to be_nil
  end
end