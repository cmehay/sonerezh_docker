# sonerez_docker
Sonerezh Dockerfile

## Usage

Run `mysql` or `mariadb` container

```sh
docker run --name mariadb -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_USER=sonerezh -e MYSQL_PASSWORD=sonerezhpass -e MYSQL_DATABASE=sonereizh -d mariadb
```

And run sonereizh container like this ♥

```sh
docker run -P -d --link mariadb:mariadb --name sonerezh -v /path/to/music:/music:ro sonerezh
```



