default: lint test

setup:
	bundle install

test:
	bin/rspec

lint:
	bin/rubocop -a
