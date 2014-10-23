
default: clean test

prep:
	-gem install rack
	-bundle install

test:
	-compass compile public
	-rackup

clean:
	-rm fluid.db
	-compass clean public
