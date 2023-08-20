Installing and running the project

Install postgresql as per https://www.postgresql.org/docs/current/tutorial-install.html

Install ruby version 3.2.2

``` bash
\curl -sSL https://get.rvm.io | bash -s stable
rvm install 3.2.2
```

Install the rails gem

``` bash
gem install rails
```

Install the bundler gem

``` bash
gem install bundler
```

Run bundler to install the needed gems
``` bash
bundle install
```

Pepare the database
``` bash
bundle exec rake db:create db:migrate
```

start the rails server
``` bash
bundle exec rails server
```