# USA Prays Website

## Production Installation Instructions:

Set hostname:

    echo "usaprays.org" > /etc/hostsname

Upgrade packages:

    aptitude update && aptitude upgrade

Install public key, delete root password

    ...

Install curl

    apt-get -y install curl

Install Ruby via this script: https://gist.github.com/3949650

    curl -L https://gist.github.com/raw/3949650/682b20dbb724f05b4d3d965a42dc359ebf623fb8/install-ruby | bash

Install nginx, postgres and nodejs

    aptitude -y install nginx postgresql libpq-dev nodejs

Set up a postgres user

    sudo -u postgres createuser -s -P usaprays

Create a less privileged user 'deployer'

    adduser deployer --ingroup sudo

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

Back on dev server do a cold deploy

    cap deploy:cold

Back on production server, remove default nginx site and start

    rm /etc/nginx/sites-enabled/default
    
    service nginx start


## Development - how to get the specs running

Set up a clean Ubuntu 12.04 dev machine

Install curl

    apt-get -y install curl

Install Ruby via this script: https://gist.github.com/3949650

    curl -L https://gist.github.com/raw/3949650/682b20dbb724f05b4d3d965a42dc359ebf623fb8/install-ruby | bash

Install postgres and nodejs

    aptitude -y install postgresql libpq-dev nodejs

Set up a postgres user

    sudo -u postgres createuser -s -P usaprays

Copy example config files

    cp config/database.example.yml config/database.yml
    cp config/initializers/mail_chimp.example.rb config/initializers/mail_chimp.rb

Edit them filling in appropriate values

    vim config/database.yml
    vim config/initializers/mail_chimp.rb

Run Bundler

    bundle install

Then run guard

    bundle exec guard

The first time you run the tests they will be quite slow as they are actually hitting the APIs.  After that, VCR will kick in and replay the http responses so it doen't need to hit the network - making it much faster.

Use Unicorn to run a local dev server

    unicorn_rails

