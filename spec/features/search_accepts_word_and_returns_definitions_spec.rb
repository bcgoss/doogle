require 'rails_helper'

RSpec.feature 'Search' do
  it 'accepts a known word and returns definitions', js: true do
    # As a guest
    word = create :entry, word: 'word'
    definition = create :definition, text: 'something that is said'
    word.definitions << definition

    visit root_path
    # When I search for a word
    fill_in 'entry[word]', with: 'Word'
    click_on 'Doogle Search'
    # Then I see a list of definitions
    expect(current_path).to eq root_path
    within("div") do
      expect(page).to have_content 'something that is said'
    end
  end

  it 'accepts an unknown word and returns definitions', js: true do
    visit root_path
    # When I search for a word
    fill_in 'entry[word]', with: 'Word'
    click_on 'Doogle Search'
    # Then I see a list of definitions
    expect(current_path).to eq root_path
    within("div") do
      expect(page).to have_content 'something that is said'
    end
  end

  it 'returns a useful error if entry is not a word', js: true do
    visit root_path
    # When I search for a word
    fill_in 'entry[word]', with: 'asveadd'
    click_on 'Doogle Search'
    # Then I see a list of definitions
    expect(current_path).to eq root_path
    within("div") do
      expect(page).to have_content 'No definition found'
    end
  end
end