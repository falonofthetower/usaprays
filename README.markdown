# USA Prays Website

## Production Installation Instructions:

Set hostname:

    echo "usaprays.org" > /etc/hostsname  (NOT recommended on Amazon EC2)

Upgrade packages:

    sudo aptitude update && sudo aptitude upgrade

Install public key, delete root password

    ...

Install curl, if not already installed

    sudo apt-get -y install curl

Install Ruby via this script: https://gist.github.com/3949650

    curl -L https://gist.github.com/raw/3949650/682b20dbb724f05b4d3d965a42dc359ebf623fb8/install-ruby | bash

    The script:
                # The version of Ruby to be installed
                ruby_ver="1.9.3-p392"

                # The base path to the Ruby
                ruby_home="/usr/local"

                # Enable truly non interactive apt-get installs
                export DEBIAN_FRONTEND=noninteractive

                sudo apt-get update
                sudo apt-get -y install git-core
                sudo apt-get -y install curl
                sudo apt-get -y install build-essential # Needed to install the make command
                sudo apt-get -y install zlib1g-dev libssl-dev libreadline-dev
                sudo apt-get -y install libxml2-dev libxslt-dev

                # Use ruby-build to install Ruby
                clone_dir=/tmp/ruby-build-$$
                sudo git clone https://github.com/sstephenson/ruby-build.git $clone_dir
                sudo $clone_dir/bin/ruby-build "$ruby_ver" "$ruby_home"
                sudo rm -rf $clone_dir
                sudo unset clone_dir

Install nginx, postgres and nodejs

    sudo aptitude -y install nginx postgresql libpq-dev nodejs

Set up a postgres user

    sudo -u postgres createuser -s -P usaprays

    also need to set the password for the user using psql and in the database.yml file (below)

Create a less privileged user 'deployer'

    sudo adduser deployer --ingroup sudo
        password: 12charles34
    put your public key in the file /home/deployer/.ssh/authorized_keys
    On the server use the command 'sudo visudo' and make sure that these lines
    appear to remove the need for the sudoer to enter a password
        # Allow members of group sudo to execute any command
        %sudo   ALL=(ALL:ALL) NOPASSWD:ALL

Switch to deployer user

    su deployer

Attempt to connect to github and say 'yes' when asked to continue.  This adds githubs host key.  Expect permission denied error.

    ssh git@github.com

Create ssh key pair (no passphrase, just hit enter)

    ssh-keygen

View and copy paste public key into github admin interface as a 'deploy key'

    cat ~/.ssh/id_rsa.pub

Back on the dev server, cross fingers and run capistrano

    cap deploy:setup

If everything goes ok, you'll be instructed to edit shared files on the production server

    vim /home/deployer/apps/usaprays/shared/config/database.yml
    vim /home/deployer/apps/usaprays/shared/config/initializers/mail_chimp.rb

On the prod server install bundler
    sudo gem install bundler

Back on dev server do a cold deploy

    cap deploy:cold

Back on production server, remove default nginx site and start

    sudo rm /etc/nginx/sites-enabled/default
    
    sudo service nginx start


## Development - how to get the specs running

Set up a clean Ubuntu 12.04 dev machine

Keep the clock in sync
    sudo apt-get -y install ntp

Install curl (if not already installed)

    sudo apt-get -y install curl

Install Ruby via this script: https://gist.github.com/3949650

    curl -L https://gist.github.com/raw/3949650/682b20dbb724f05b4d3d965a42dc359ebf623fb8/install-ruby | bash

Install postgres, imagemagick and nodejs

    sudo aptitude -y install postgresql imagemagick libpq-dev nodejs

Set up a postgres user

    sudo -u postgres createuser -s -P usaprays

Copy example config files

    cp config/database.example.yml config/database.yml
    cp config/initializers/mail_chimp.example.rb config/initializers/mail_chimp.rb

Edit them filling in appropriate values

    vim config/database.yml
       This needs port: 5543 added in the case of the default postgres install.
    vim config/initializers/mail_chimp.rb

Run Bundler

    bundle install

Then run guard

    bundle exec guard

To get unicorn to auto start with server start.

    sudo update-rc.d unicorn_usaprays defaults

The first time you run the tests they will be quite slow as they are actually hitting the APIs.  After that, VCR will kick in and replay the http responses so it doen't need to hit the network - making it much faster.

Use Unicorn to run a local dev server

    unicorn_rails

On Server, edit crontab to add daily task for backup

    sudo crontab -e
        Add this line
    0 3 * * * /bin/bash -l -c 'cd /home/deployer/apps/usaprays/current && RAILS_ENV=production bundle exec rake backup --silent'
    0 5 * * * /bin/bash -l -c 'cd /home/deployer/apps/usaprays/current && RAILS_ENV=production bundle exec rake clear_cache --silent'
