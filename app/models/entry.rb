class Entry < ApplicationRecord
  has_many :entries_definitions
  has_many :definitions, through: :entries_definitions
  validates :word, presence: true, uniqueness: {case_sensitive: false}
  before_validation :downcase_word

  def downcase_word
    word.downcase!
  end

  def self.lookup(word: '')
    result = find_by(word: word.downcase)
    unless result
      result = create_from_dictionary(DictionaryService.lookup(word))
    end

    return result
  end

  def self.create_from_dictionary(dictionary_result)
    if dictionary_result.nil?
      new_word = NullEntry.new
    else
      new_word = find_or_create_by(word: dictionary_result[:word])
      dictionary_result[:definitions].each do |definition|
        new_word.definitions.find_or_create_by(text: definition)
      end
    end
    return new_word
  end

  class NullEntry
    def word
      'Invalid word'
    end

    def definitions
      [Definition::NullDefinition.new]
    end
  end
end

