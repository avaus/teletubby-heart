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

* Migrate the development and test databases
```
rake db:migrate
RAILS_ENV=test rake db:migrate
RAILS_ENV=production rake db:migrate
```

* Import fixtures to the development database
```
rake db:seed
```

* Start pub/sub server. Append '-p 9290' if production
```
rackup private_pub.ru -s thin -E production
```

* Check that tests pass by running 
```
bundle exec rspec spec/
```

* Start application server. Append '-e production' if production
```
rails server
```

Usage
-----

* Go to http://localhost:3000


Authors
-------


License
-------

Licensed under the MIT license.
