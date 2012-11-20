module AstDB
  class Entry
    
    attr_accessor :family, :key, :value
    
    def initialize(key, value)
      m = key.match /^(?<family>.+)\/(?<key>[^\/]+)$/
      raise ArgumentError, 'key must at least have a single "/" delimiting the asterisk family and key values' if m.nil?
      
      @family = m[:family]
      @key    = m[:key]
      @value  = value
    end
    
    def put_command
      "database put #{family} #{key} #{value}"
    end
    
  end
end