module AstDB
  class Connection
    require 'net/ssh'
    
    attr_accessor :host, :username, :password
        
    def initialize(opts = {})
      @host     = opts[:host]
      @username = opts[:username]
      @password = opts[:password]
    end
        
    def fetch_database
      
      # fetch database dump from asterisk server
      
      output = nil
      
      Net::SSH.start(@host, @username, password: @password) do |ssh|
        output = ssh.exec!("asterisk -rx 'database show'")
      end

      # parse dump to hash
      
      database = {}
      
      lines = output.split("\n").collect { |l| l.rstrip }
      lines.each do |line|
        m = line.match /^\/(?<key>[^:]+):(?<value>.+)$/    
        next if m.nil?
        key   = m[:key].rstrip
        value = m[:value].lstrip
        
        database[key] = value
      end

      database
    end
    
    def set_database_values(value_hash)
      
      # prepare command
      
      commands = value_hash.collect { |k, v| Entry.new(k,v).put_command }

      # send to server
      
      errors = {}
      
      Net::SSH.start(@host, @username, password: @password) do |ssh|
        value_hash.each do |key, value|
          command = Entry.new(key,value).put_command
          
          response = ssh.exec!("asterisk -rx '#{command}'")
          errors[key] = response unless response.match /Updated database successfully/
        end
      end
       
      return errors.count > 0 ? errors : nil
    end
    
  end
end