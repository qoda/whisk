Whisk (Training Assignment)
===========================

A simple word scramble game utilising coffescript, haml, rails and redis.
Scoring is based on the popular board game scrabble.

Launch
------

Local::
    $ git clone git@github.com:qoda/whisk.git
    $ cd whisk
    $ bundle install
    $ rake db:migrate
    $ rake dictionary:sync
    $ rails s
