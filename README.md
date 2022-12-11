# WevSTAT Blog System

====

Overview

## Description
[WevSTAT](http://koucs.com) WEB Page's Blog System developed by Ruby on Rails.

## Demo
Currently, this system is working here -> [WevSTAT](http://koucs.com)

## Requirement
- ruby 2.2.2p95
- Rails 4.1.7

## Install

### Set up Rails app
First, install the gems required by the application:

```
$ bundle
```

Next, execute the database migrations/schema setup:

```
$ bundle exec rake db:setup
```

### Start Rails Server

```
$ ./bin/rails s
```

## Debug

### connect to postgre sql server on Heroku

```
PGSSLMODE=require psql -h $HEROKU_BLOG_HOST -p 5432 -U $HEROKU_BLOG_USER -d $HEROKU_BLOG_DB -W
```

### DB URL

`postgres://$HEROKU_BLOG_USER:$HEROKU_BLOG_PASSWD@$HEROKU_BLOG_HOST:5432/$HEROKU_BLOG_DB`

### backup database

```
pg_dump -U $HEROKU_BLOG_USER -W -F p $HEROKU_BLOG_DB -h $HEROKU_BLOG_HOST > ./22-01-15_gra-gazing-duly-2681.sql
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[Acto](https://github.com/Acto)
