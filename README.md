Teletubby-Heart
===============

Teletubby is easily extensible, good looking and accessible "Information Radiator". It can display relevant information e.g. build statuses, project status, billing forecasts, project schedules, video streams etc. on multiple different devices.

The "heart" is the core of Teletubby (someone might even call it the backend). It serves the content to the client devices.

Requirements
------------

* Ruby 1.9.3
* Bundler

Installation
------------

* Clone the repository

* Run "bundle install"

* Rename config/database.yml.tmpl to config/database.yml
    * Configure the database.yml if needed

* Migrate the development and test databases
```
rake db:migrate
RAILS_ENV=test rake db:migrate
```

* Import fixtures to the development database
```
rake db:seed
```

* Check that tests pass by running "bundle exec rspec spec/"

* Run "rails server"


Usage
-----

* Go to http://localhost:3000


Authors
-------


License
-------

Licensed under the ** license.