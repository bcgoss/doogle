class DictionaryService
  def self.lookup(word)
    DictionaryService.new(word).lookup
  end

  def initialize(word, url: DICTIONARY_URL)
    @word = word
    @connection = Faraday.new(url: url)
  end

  def lookup
    parse response.body
  end

  private
    DICTIONARY_URL = 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/'
    ENTRY_XPATH = '//ew'
    DEFINITION_XPATH = '//dt'

    attr_reader :connection, :word

    def response
      @response ||= connection.get word, {key: ENV['DictionaryAPIKey']}
    end

    def document(raw_xml)
      @xml ||= Nokogiri::XML(raw_xml)
    end

    def parse(raw_response)
      xml = document(raw_response)
      word_list = extract_text(xml, ENTRY_XPATH)

      return nil if word_list.empty?
      word = word_list.first
      definitions = extract_text(xml, DEFINITION_XPATH)

      {word: word, definitions: definitions}
    end

    def extract_text(document, target)
      cleanup(document.search(target).map(&:text))
    end

    def cleanup(raw_text)
      raw_text.map { |text| text.gsub(':', '') }.select { |text| text unless text.blank? }
    end
end