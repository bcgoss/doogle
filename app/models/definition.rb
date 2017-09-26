class Definition < ApplicationRecord
  has_many :entries_definitions
  has_many :entries, through: :entries_definitions

  class NullDefinition
    def text
      'No definition found'
    end

    def entry
      NullEntry.new
    end
  end
end
