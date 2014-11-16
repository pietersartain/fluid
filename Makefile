
default: clean run

prep:
	-gem install rack
	-bundle install

run:
	-compass compile public
	-rackup

test:
	-rspec

clean:
	-rm fluid.db
	-compass clean public
