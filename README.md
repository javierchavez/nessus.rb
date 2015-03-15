# Nessus
[![Build Status](https://travis-ci.org/javierchavez/nessus.rb.svg)](https://travis-ci.org/javierchavez/nessus.rb)

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'nessus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nessus

## Usage

require gems 

```ruby
	require 'rubygems'
	require 'nessus'
```	

Connecting using a SSL cert 


```ruby
	# create a client, but dont login yet.
    # nil nil are username and password respectivly.
	client = Nessus::Client.new(
	    "https://00.10.010.110:8834", 
    	nil, 
	    nil, 
    	{ ssl: { :ca_file => '~/dir/01.11.191.17.cer'}})	
        
    
    # now login
    client.login("user", "pwd") 
    
    # Check if authenticated
    puts client.authenticated? 
    
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
