Babblr, a blogging app.
=======================

by Mike Goren

This is a simple Ruby/Rails blogging app.
3/27/15 - added multi-user with user auth

Demo
----
https://ibabblr.herokuapp.com/


Installation
------------

Install Babblr by first cloning the repository.  
```
$ git clone http://github.com/mgoren/babblr.git
```

Start the database:
```
$ postgres
```

Create the databases, tables, and test environment by running the following:
```
$ rake db:create
$ rake db:migrate
$ rake db:test:prepare
```

Start the rails server:
```
$ rails s
```

In your web browser, go to http://localhost:3000

License
-------

GNU GPL v2. Copyright 2015
