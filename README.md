Teletubby-Heart
===============

Teletubby is easily extensible, good looking and accessible "Information Radiator". It can display relevant information e.g. build statuses, project status, billing forecasts, project schedules, video streams etc. on multiple different devices.

The "heart" is the core of Teletubby (someone might even call it the backend). It serves the content to the client devices.

Requirements
------------

* Ruby 1.9.3
* Bundler
* ImageMagick

Installation
------------

* Clone the repository

* Install gems 
```
bundle install
```

* Rename config/database.yml.example to config/database.yml
    * Configure the database.yml if needed

* Rename config/private_pub.yml.example to config/private_pub.yml
    * Configure the private_pub.yml if needed

* Migrate the development and test databases
```
rake db:migrate
RAILS_ENV=test rake db:migrate
```

* Import fixtures to the development database
```
rake db:seed
```

* Check that tests pass by running 
```
bundle exec rspec spec/
```

* Start application server 
```
rails server
```

* Start pub/sub server. Change the port to 9292 on development or test environment
```
rackup private_pub.ru -s thin -E production -p 9290
```

Usage
-----

* Go to http://localhost:3000


Authors
-------


License
-------

Licensed under the ** license.
