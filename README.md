# :zap::angel: Enel

Remove duplicate logic that use thor.

[![Gem Version](https://badge.fury.io/rb/enel.svg)](http://badge.fury.io/rb/enel)
[![Build Status](https://travis-ci.org/tbpgr/enel.png?branch=master)](https://travis-ci.org/tbpgr/enel)

## :notes: Images
### :baby_chick: Before

:zap:  
1 :turtle::rabbit::dragon:(1)  
2 :turtle::rabbit::dragon:(2)  
3 :turtle::rabbit::dragon:(3)  
4 :turtle::rabbit::dragon:(4)  

### :chicken: After

:zap::angel:  
1  
2  
3  
4  
:sparkles::sparkles:

## :cloud::arrow_down: Installation

Add this line to your application's Gemfile:

```ruby
gem 'enel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enel

## :scroll: Usage
### :mouse: Sample Case
#### :baby_chick: Before use

* hoge.rb

~~~ruby
require 'thor'
require_relative './commands/hoges'

class Hoge < Thor
  desc 'hoge1', 'hoge1'
  def hoge1
    puts Commands::Hoge1.run
  end

  desc 'hoge2', 'hoge2'
  def hoge2(args1)
    puts Commands::Hoge2.run(args1)
  end

  desc 'hoge3', 'hoge3'
  def hoge3(args1, *options)
    puts Commands::Hoge3.run(args1, *options)
  end

  # hoge4, hoge5... more!
end

Hoge.start(ARGV)
~~~

* ./commands/hoges.rb

~~~ruby
module Commands
  class Hoge1
    def run
      "hoge1"
    end
  end

  class Hoge2
    def run(args1)
      args1
    end
  end

  class Hoge3
    def run(args1, *options)
      [args1, *options]
    end
  end

  # hoge4, hoge5... more!
end
~~~

* result

~~~
$ ruby hoge.rb hoge1
hoge1
$ ruby hoge.rb hoge2 a
a
$ ruby hoge.rb hoge3 a b c
a
b
c
~~~

#### :chicken: After use
~~~ruby
require 'thor'
require 'active_support/inflector'
require 'enel'
require_relative 'commands/hoges'

class Hoge < ::Thor
  extend Enel

  desc 'hoge1', 'hoge1'
  def hoge1
  end

  desc 'hoge2', 'hoge2'
  def hoge2(args1)
  end

  desc 'hoge3', 'hoge3'
  def hoge3(args1, *options)
  end

  # hoge4, hoge5... more!

  define_call_command(proc { |*args|
    command = args.first.to_s.camelize
    params = args[1..-1]
    puts Object.const_get("Commands::#{command}").new.run(*params)
  })
end

Hoge.start(ARGV)
~~~

* result

~~~
$ ruby hoge.rb hoge1
hoge1
$ ruby hoge.rb hoge2 a
a
$ ruby hoge.rb hoge3 a b c
a
b
c
~~~

## :two_men_holding_hands: Contributing :two_women_holding_hands:

1. Fork it ( https://github.com/tbpgr/enel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
