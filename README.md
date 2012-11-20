# AstDB

Interact with an Asterisk Database (AstDB) instance via ssh.

## Installation

Add this line to your application's Gemfile:

    gem 'astdb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install astdb

## Usage

```ruby
require 'astdb'

db = AstDB::Database.new host:     		'ssh.server.com',
                         username: 		'not-root',
                         password: 		'Secret!',        # Omit this line if using key-based auth.
												 auto_reload: true              # Optionally disable the automatic initial load
												                                # and updating of '.hash', instead opting to run
												                                # '.reload_database' manually. Useful in high 
												                                # latency or low bandwidth scenarios. 
																												# Default: true 

# view a hash of the database
p db.hash

# add/update some entries
errors = db.set({'MyFamily/MyKey' => 'MyValue', 'this/is/a/longer/key' => 'another value'})

if errors
	errors.each { |key, error_message| p "The following error occurred when trying to set #{key}: #{error}"
end

# see the updated database
p db.hash
'''

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
