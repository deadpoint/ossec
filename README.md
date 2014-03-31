ossec
========

## Usage

Once you have your module then install the development dependencies:

    cd puppet-ossec
    gem install bundler --no-rdoc --no-ri
    bundle install

Now you should have a bunch of rake commands to help with your module
development:

    bundle exec rake -T

    rake acceptance    # Run all acceptance tests: Will load module dependencies, then start all VMs in serial and execute tests ...
	rake lint          # Check puppet manifests for lint errors
	rake unit          # Run all unit tests
	rake vagrant_prep  # Loads / refreshes this module and module dependencies in preparation for Vagrant provisioning


