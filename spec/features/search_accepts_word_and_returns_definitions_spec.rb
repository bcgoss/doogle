require 'rails_helper'

RSpec.feature 'Search' do
  it 'accepts a known word and returns definitions', js: true do
    # As a guest
    create :entry, word: 'word'
    visit root_path
    # When I search for a word
    fill_in 'entry[word]', with: 'Word'
    click_on 'Doogle Search'
    # Then I see a list of definitions
    expect(current_path).to eq root_path
    within("div") do
      expect(page).to have_content 'hi'
    end
  end
end