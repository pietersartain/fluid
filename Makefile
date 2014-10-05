
default: clean test

prep:
	-gem install rack
	-bundle install

test:
	-rackup

clean:
	-rm fluid.db
