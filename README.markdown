# USA Prays Website

## Production Installation Instructions:

Set hostname:

    echo "usaprays.org" > /etc/hostsname

Upgrade packages:

    aptitude update && aptitude upgrade

Install public key, delete root password

Install curl

    apt-get -y install curl

Add Nginx repository

    add-apt-repository ppa:nginx/stable

Update the package manager with the new repository and install Nginx

    aptitude update  && aptitude -y install nginx

Start Nginx

    service nginx start

Add repository for latest version of PostgreSQL

    add-apt-repository ppa:pitti/postgresql

Update repo and install PostgreSQL

    aptitude update && aptitude -y install postgresql libpq-dev

Enter into postgres shell as the postgres user

    sudo -u postgres psql

Set password for Postgres

    postgres=# \password
    Enter new password: 
    Enter it again:

Create user and database for psp app

    postgres=# create user psp with password 'changeme';
    CREATE ROLE
    postgres=# create database psp_production owner psp;
    CREATE DATABASE

Exit postgres shell

    \quit

Install node.js repository

    add-apt-repository ppa:chris-lea/node.js

Update and install node.js

    aptitude update && aptitude -y install nodejs

Create a less priveledged user 'deployer'

    adduser deployer --ingroup sudo


Install Ruby

curl -L https://gist.github.com/raw/3949650/43a25b811366d053c6448d8bde1faf317ae51d13/install-ruby | bash

Attempt to connect to github and say 'yes' when asked to continue.  This adds githubs host key.  Expect permission denied error.

    ssh git@github.com

Create ssh key pair (no passphrase, just hit enter)

    ssh-keygen

View and copy paste public key into github admin interface for this repository

    cat ~/.ssh/id_rsa.pub

Cross fingers and run capistrano from development server

    cap deploy:setup

Back on new PublicServantsPrayer production server, edit config files as the deployer user

    vim apps/psp/shared/config/database.yml

Back on dev server

    cap deploy:cold

Back on production server, remove default nginx and restart

    rm /etc/nginx/sites-enabled/default
    
    service nginx restart


## Development - how to get the specs running

### This assumes a fairly clean Ubuntu 12.04 dev work station with Rbenv/RVM installed ruby 1.9.3

Install packages to enable PPA repositories and other things

    apt-get -y install curl git-core python-software-properties

Add repository for latest version of PostgreSQL

    add-apt-repository ppa:pitti/postgresql

Update repo and install PostgreSQL

    aptitude update && aptitude -y install postgresql libpq-dev

Enter into postgres shell as the postgres user

    sudo -u postgres psql

Create user that can create databases

    postgres=# create user usaprays with createdb password 'changeme';
    CREATE ROLE

Exit postgres shell

    \quit

Install node.js repository

    add-apt-repository ppa:chris-lea/node.js

Update and install node.js

    aptitude update && aptitude -y install nodejs

Copy the mail_chimp example file and fill in with key and list number

    cp config/initializers/mail_chimp.example.rb config/intitializers/mail_chimp.rb

Run Bundler

    bundle install

Then run guard

    bundle exec guard

The first time you run the tests they will be quite slow as they are actually hitting the APIs.  After that VCR kicks in and replays the http responses so it doen't need to hit the network - making it much faster.

Use Unicorn to run a local dev server

    unicorn_rails

