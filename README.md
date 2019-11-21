# Celery demo with Django

[中文版](./README-CN.md)

This is a naive demo that Django integrate with Celery as following.


![](https://counter2015.com/picture/celery.gif)


## Run

You should first run a local Redis instance at default port 6379.

```shell
$ git clone https://github.com/counter2015/celeryDemo.git

# init python venv and download packages
$ bin/venv_init.sh

# mkdir for pid and logs storage, migrate database
$ bin/deploy.sh

# this will start server at http://localhost:8011
$ bin/run.sh

# you can stop server by this command
$ bin/stop.sh
```

