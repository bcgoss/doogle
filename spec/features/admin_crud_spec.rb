require 'rails_helper'

RSpec.describe 'Admins' do
  context 'entries' do
    it 'can view all known words' do
      create :entry, word: 'stuff'
      create :entry, word: 'thing'

      visit admin_entries_path

      expect(page).to have_content('stuff')
      expect(page).to have_content('thing')
    end

    it 'can view a single word with definitions' do
      subject = create :entry, word: 'stuff'
      definition = create :definition, text: 'materials, supplies, or equipment used in various activities'
      subject.definitions << definition

      visit admin_entries_path
      click_link 'stuff'

      expect(page).to have_content('materials, supplies, or equipment used in various activities')
    end

    it 'can add new words' do
      visit admin_dashboard_path

      click_on 'Add an entry'

      fill_in 'Word', with: 'stuff'
      click_on 'Create Entry'

      expect(page).to have_content 'stuff'
    end

    it 'can edit a word' do

      subject = create :entry, word: 'wrong'

      visit admin_entry_path(subject.id)

      click_on 'Edit'

      fill_in 'Word', with: 'right'
      click_on 'Update Entry'

      expect(page).to have_content 'right'
      expect(current_path).to eq admin_entry_path(subject.id)
    end

    it 'can delete words' do
      subject = create :entry, word: 'subject'
      create :entry, word: 'other_word'

      visit admin_entry_path(subject.id)

      click_on 'Delete'

      expect(current_path).to eq admin_entries_path
      expect(page).to_not have_content 'subject'
      expect(page).to have_content 'other_word'
    end
  end

  context 'definitions' do
    it 'can view all definitions' do
      create :definition, text: 'first definition'
      create :definition, text: 'second definition'

      visit admin_definitions_path

      expect(page).to have_content 'first definition'
      expect(page).to have_content 'second definition'
    end

    it 'can view a single definition' do
      subject = create :definition, text: 'materials, supplies, or equipment used in various activities'
      entry = create :entry, word: 'stuff'
      entry.definitions << subject

      visit admin_definitions_path

      click_on subject.text

      expect(page).to have_content 'stuff'
      expect(page).to have_content 'materials, supplies, or equipment used in various activities'
    end

    it 'can add a new definition' do
      visit admin_dashboard_path

      click_on 'Add a definition'
      fill_in 'Text', with: 'A new definition'
      click_on 'Create Definition'

      expect(page).to have_content 'A new definition'
    end

    it 'can edit a definition' do
      subject = create :definition, text: 'Wrong definition'

      visit admin_definition_path(subject.id)

      click_on 'Edit'
      fill_in 'Text', with: 'Correct definition'
      click_on 'Update Definition'

      expect(page).to have_content 'Correct definition'
    end

    it 'can delete defintions' do
      subject = create :definition, text: 'Delete me'
      create :definition, text: 'Remaining definition'

      visit admin_definition_path(subject.id)
      click_on 'Delete'

      expect(current_path).to eq admin_definitions_path
      expect(page).to_not have_content 'Delete me'
      expect(page).to have_content 'Remaining definition'
    end
  end
end