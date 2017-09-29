class Definition < ApplicationRecord
  has_many :entries_definitions
  has_many :entries, through: :entries_definitions

  class NullDefinition < Definition
    def text
      'No definition found'
    end

    def entries
      [Entry::NullEntry.new]
    end
  end
end
