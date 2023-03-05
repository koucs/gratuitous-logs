## Supabase への移行

[Migrate from Heroku to Supabase](https://supabase.com/docs/guides/resources/migrating-to-supabase/heroku)

```s
psql -h $SUPABASE_HOST -U postgres -f heroku_dump.sql
```
## troubleshoot

```s
$ pg_dump --clean --if-exists --quote-all-identifiers -h $HEROKU_BLOG_HOST -U $HEROKU_BLOG_USER -d $HEROKU_BLOG_DB --no-owner --no-privileges > heroku_dump.sql
pg_dump: error: server version: 14.6 (Ubuntu 14.6-1.pgdg20.04+1); pg_dump version: 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)
pg_dump: error: aborting because of server version mismatch
```

postgres version 14 をインストールするも、下記のエラーが継続

```s
$ pg_dump
Error: PostgreSQL version 12 is not installed
```

apt command で postgres 14 をインストールし、[こちら](https://dba.stackexchange.com/questions/303607/pg-dump-is-not-the-same-version-as-psql) で解決

```s
$ sudo pg_dropcluster 12 main
```

## backup database

```
pg_dump -U $HEROKU_BLOG_USER -W -F p $HEROKU_BLOG_DB -h $HEROKU_BLOG_HOST > ./22-01-15_gra-gazing-duly-2681.sql
```

 ([Heroku Postgres から Supabase への移行で使用した3つのコマンド](https://zenn.dev/shiroemons/articles/c0fa5ba3bb6239))

```
$ heroku pg:backups:capture
$ heroku pg:backups:download
```
=> Store the backup files as `./lastest.dump`