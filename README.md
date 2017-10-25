# PHP Web Dev Environment Dockerfile Example

- CentOS 7
- Apache 2.4
- PHP 5.4
- SSH
- grunt-cli

# How to build

```
$ docker build -t php-webdev-env-example .
```

# How to run

```
$ docker run --rm -it -d -p 2222:22 -p 8080:80 -v /path/to:/var/www/myproject php-webdev-env-example
```

# Test

Go http://localhost:8080/index.php

