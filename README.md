# VettedComment

This is ugly but it gets the point across (using ActiveSupport::TestCase outside of Rails)

## Installation

## Download

~~~
git clone git@github.com:avogeltanz/vetted_comment.git
cd vetted_comment
~~~

## Ruby setup

### Tested with
Should work with ruby-2.1.0 and above.  If you use another
version modify .ruby-version file so that rvm or rbenv will
know it is the version to use on entering this folder.

### RVM

~~~
rvm install ruby-2.3.0
~~~

### rbenv

~~~
rbenv install ruby-2.3.0
rbenv local ruby-2.3.0
~~~

## Running

Execute:
~~~
# Installs all gem dependencies
$ bundle install

# Will run the tests
$ bundle exec rake test
~~~
