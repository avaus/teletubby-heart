Teletubby-Heart
===============

Teletubby is easily extensible, good looking and accessible "Information Radiator". It can display relevant information e.g. build statuses, project status, billing forecasts, project schedules, images, video streams etc. on multiple different devices.

The "Heart" is the core of Teletubby (someone might even call it the backend). It serves the content to the client devices.

Requirements
------------

* Vagrant
* VirtualBox

Installation
------------

* Clone this repository and submodules
```
git clone --recursive git@github.com:avaus/teletubby-heart.git
```

* Install gems
```
cd /vagrant && bundle install
```

* Configure databases
```
cp /vagrant/config/database.yml.example /vagrant/config/database.yml
```

* Setup databases
```
rake db:migrate
rake db:test:load
rake db:seed
```

* Run tests
```
bundle exec rspec
```

* Start rails and pub/sub servers
```
service rails start
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
