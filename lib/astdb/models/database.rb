module AstDB
  class Database
    
    attr_reader :connection, :hash
    
    def initialize(opts = {})
      @connection  = Connection.new host:     opts[:host],
                                    username: opts[:username],
                                    password: opts[:password]
                                    
      @auto_reload  = opts[:auto_reload].nil? ? true : opts[:auto_reload]
      @database     = {}
    
      reload_database if @auto_reload
    end
    
    def set(value_hash)
      errors = @connection.set_database_values(value_hash)
      reload_database if @auto_reload
      
      errors
    end
        
    def reload_database
      @hash = @connection.fetch_database
    end
    
  end
end