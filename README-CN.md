# Celery demo with Django

[English](./README.md)

一个Django和Celery集成的简单示例，如下图所示。



![](https://counter2015.com/picture/celery.gif)


## Run

需要先在本地6379端口启动Redis实例。

```shell
$ git clone https://github.com/counter2015/celeryDemo.git

# 初始化python虚拟环境，下载依赖包
$ bin/venv_init.sh

# 创建运行时需要的文件夹，初始化数据库(这里没有用到数据库)
$ bin/deploy.sh

# 启动服务，将运行在 http://localhost:8011
$ bin/run.sh

# 你可以通过以下命令关闭服务
$ bin/stop.sh
```

