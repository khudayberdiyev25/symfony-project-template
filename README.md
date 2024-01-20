# symfony6-docker
symfony6 docker

### Docker
To start docker containers:

```
make start
```

To destroy containers:
```
make rm
```

### Composer
To install packages:

```
make composer-install
```

### Database migrations
To run migration

```
make migration-up
```

Rollback the last migration

```
make migration-down
```

Generate new migration file

```
make migration-generate
```

Create test db to run functional tests

```
make create-test-database
```

### PHP Static fixer
```
make php-cs-fix
```

### Functional test
```
make test-functional
```

