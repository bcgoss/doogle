class Definition < ApplicationRecord
  belongs_to :entry

  class NullDefinition
    def text
      'Word not found'
    end

    def entry
      NullEntry.new
    end
  end
end
