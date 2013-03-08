Teletubby-Heart
===============

Teletubby is easily extensible, good looking and accessible "Information Radiator". It can display relevant information e.g. build statuses, project status, billing forecasts, project schedules, images, video streams etc. on multiple different devices.

The "Heart" is the core of Teletubby (someone might even call it the backend). It serves the content to the client devices.

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

* Check that tests pass by running 
```
bundle exec rspec spec/
```

* Start application server. Append '-e production' if production
```
rails server
```

* Start pub/sub server. Append '-p 9290' if production
```
rackup private_pub.ru -s thin -E production
```

Usage
-----

* Go to http://localhost:3000


Authors
-------

[Vesa Paakkanen](https://github.com/Dige)

[Antti Pitkänen](https://github.com/anttipitkanen)

[Jussi Perämäki](https://github.com/jperamak)

[Sampo Verkasalo](https://github.com/RedBulli)

[Verneri Suomalainen](https://github.com/Khoba)

[Matias Kantele](https://github.com/matiisi)

[Aleksi Taipale](https://github.com/aleksita)

[Samuli Suortti](https://github.com/Smulis)

License
-------

Licensed under the MIT license.
