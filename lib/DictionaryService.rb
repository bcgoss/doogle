
class DictionaryService
  def self.lookup(word)
    DictionaryService.new(word).lookup
  end

  def initialize(word)
    @word = word
  end

  def lookup
    parse response.body
  end

  def response
    connection.get @word, {key: ENV['DictionaryAPIKey']}
  end

  def connection
    Faraday.new(url: 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/')
  end

  def parse(response)
    word_list = Nokogiri::XML(response).search('//ew')
    if word_list.empty?
      return nil
    else
      word = word_list.first.text
    end
    raw_definitions = Nokogiri::XML(response).search('dt > text()').map(&:text)
    definitions = cleanup(raw_definitions)
    {word: word, definitions: definitions}
  end

  def cleanup(raw_text)
    raw_text.map { |text| text.gsub(':', '') }.select { |text| text unless text.blank? }
  end
end