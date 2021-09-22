# 电商api实现

##  中文翻译包
```shell
$ composer require overtrue/laravel-lang
```

##  jwt 认证
```shell
$ composer require tymon/jwt-auth
```

##  雪花算法
```shell
$ composer require godruoyi/php-snowflake
```

##  修改路由器的默认语法为@形式

https://laravel.com/docs/8.x/upgrade#seeder-factory-namespaces

##  短信
```shell
$ composer require overtrue/easy-sms
```

##  定时任务

使用定时任务来处理订单超时未支付问题，

支付订单后删除队列任务中记录未支付订单信息

##  通知

支付订单成功后发送站内信提示用户支付成功

## 众筹功能

与普通商品相比，众筹商品有如下特殊的业务逻辑：
- 需要设置目标金额与截止时间
- 到达截止时间时如果总订单金额低于目标金额则众筹失败，并退款所有订单 
- 到达截止时间时如果总订单金额大等于目标金额则众筹成功
- 众筹订单不支持用户主动申请退款 
- 在众筹成功之前订单不可发货

## 分期付款

- 只有当商品订单总金额高于某个数值时才可以使用分期付款；
- 用户使用分期付款时，需要选择还款期限，通常为 3 个月的倍数；
- 使用分期付款需要支付手续费，不同的还款期限手续费费率不同，还款期限越久费率越高；
- 分期付款的手续费与银行贷款的利息不同，银行贷款的利息会随着还款而逐渐降低，而分期付款的手续费则是固定的；
- 使用分期付款后，用户需要立即支付第一期的费用，当第一期费用支付成功后，对应的商品订单状态即变为已支付；
- 用户需每 30 天还款一次，如果在还款截止日期之后仍未还款，需支付逾期费，逾期费按天计算；
- 逾期之后产生的逾期费用最多不超过当期的本金 + 手续费；
- 每一期还款金额计算公式：(本金 + 手续费) / 还款期数 + 当期逾期费；
- 使用了分期付款的商品订单如果发生退款，则退回所有已支付的本金，手续费与逾期费不退回。

## 金额计算

```shell
$ composer require brick/math
```

## Elasticsearch

```shell
$ composer require elasticsearch/elasticsearch
```


```shell
$ docker pull elasticsearch:7.14.1
$ docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms200m -Xmx200m" elasticsearch:7.14.1
```
-  安装 analysis-ik 中文分词插件

```shell
$ docker exec -it es /bin/bash
# ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.14.1/elasticsearch-analysis-ik-7.14.1.zip
```

-  拷贝配置文件到本地

```shell
$ cd elasticsearch7
$ docker cp es:/usr/share/elasticsearch/config ./
$ docker cp es:/usr/share/elasticsearch/data ./
$ docker cp es:/usr/share/elasticsearch/plugins ./
```
- 编辑配置文件

$ vim jvm.options

-Xms200m

-Xmx200m

$ vim elasticsearch.yml
```yaml
node.name: master
http.cors.enabled: true
http.cors.allow-origin: "*"
network.host: 0.0.0.0
```

- 重启docker

```shell
$ docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -v /Users/xiaoxiao/dev/server/elasticsearch7/config:/usr/share/elasticsearch/config -v /Users/xiaoxiao/dev/server/elasticsearch7/data:/usr/share/elasticsearch/data -v /Users/xiaoxiao/dev/server/elasticsearch7/plugins://usr/share/elasticsearch/plugins elasticsearch:7.14.1
```

## 秒杀

### 优化

> 库存

 - 查看接口的所有执行的SQL语句，将可以由数据库查询的转换成由传递参数，比如 创建订单时记录用户地址信息时不再传递地址id而是传递地址信息数组减少查询
 - 秒杀商品的库存保存到 Redis 中，有用户创建秒杀订单就将对应的 Redis 值减一，秒杀订单被关闭就将其值加一
 - 我们可以将用户的登陆状态判断放到商品库存判断之后，当秒杀商品没有库存时就不会走一步了


### 压测

> JMeter

JMeter 是一款由 Apache 基金会管理的使用 Java 开发的跨平台开源压力测试软件，可以用于 HTTP/HTTPS、FTP、数据库、TCP 等服务的压力测试，拥有多种测试结果展示方案，而且还支持 Groovy 和 BeanShell 脚本使其拥有强大的扩展能力。
由于 JMeter 是由 Java 开发的程序，因此需要有 Java 运行环境


### 调整FPM参数

$ vim www.conf
```apacheconf
# 默认的 dynamic 代表 PHP-FPM 进程数是动态的，当并发请求数较高时，会逐步创建新的 PHP-FPM 用于处理请求，
# 当并发请求数较低时也会销毁掉空闲的 PHP-FPM 进程。这个配置比较适合于请求数量变化比较平稳的站点，
# 而对于秒杀来说往往是短时间内突然爆发出大量的请求，dynamic 来不及创建 PHP-FPM，所以会出现错误。
pm = static
pm.max_children = 500
# 代表当一个 PHP-FPM 进程处理了 1000 个请求之后就会主动退出进程，然后再由 FPM 管理进程启动一个新的 PHP-FPM 进程，
# 这样即使有内存泄露发生，这种类似于重启的操作也会将泄露的内存释放掉。
pm.max_requests = 1000
```

### 调整mysql参数

```mysql
set global max_connections=1000;
show variables like 'max_connections';
```

$ vim mysql/mysql.conf.d/mysqld.cnf
```ini
max_connections = 1000
```

$ vim /lib/systemd/system/mysql.service
```ini
LimitNOFILE=65535
LimitNPROC=65535
```
$ systemctl daemon-reload
$ systemctl restart mysql.service

## 开启SQL日志

$ vim app/Providers/AppServiceProvider
```php

.
.
.
  public function boot()
  {
     // 只在本地开发环境启用 SQL 日志
    if (app()->environment('local')) {
        \DB::listen(function ($query) {
            \Log::info(Str::replaceArray('?', $query->bindings, $query->sql));
        });
    }
  }
```

# Deployer 部署工具

```shell
$ composer global require deployer/deployer
```
将 deployer目录下的bin目录设置到环境变量中
- /Users/xiaoxiao/.composer/vendor/deployer/deployer/bin
```shell
dep
Deployer v6.8.0

Usage:
  command [options] [arguments]

Options:
  -h, --help            Display help for the given command. When no command is given display help for the list command
  -q, --quiet           Do not output any message
  -V, --version         Display this application version
      --ansi|--no-ansi  Force (or disable --no-ansi) ANSI output
  -n, --no-interaction  Do not ask any interactive question
  -f, --file[=FILE]     Specify Deployer file
  -v|vv|vvv, --verbose  Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug

Available commands:
  autocomplete  Install command line autocompletion capabilities
  help          Display help for a command
  init          Initialize deployer in your project
  list          List commands
  run           Run any arbitrary command on hosts
  ssh           Connect to host through ssh
 debug
  debug:task    Display the task-tree for a given task
```
创建部署脚本
```shell
$ mkdir deploy-laravel-shop
$ dep init
deploy-laravel-project dep init


  Welcome to the Deployer config generator



 This utility will walk you through creating a deploy.php file.
 It only covers the most common items, and tries to guess sensible defaults.

 Press ^C at any time to quit.

 Please select your project type [Common]:
  [0 ] Common
  [1 ] Laravel
  [2 ] Symfony
  [3 ] Yii
  [4 ] Yii2 Basic App
  [5 ] Yii2 Advanced App
  [6 ] Zend Framework
  [7 ] CakePHP
  [8 ] CodeIgniter
  [9 ] Drupal
  [10] TYPO3
 > 1

 Repository []:
 > https://github.com/xiaoxiao0301/shop.git  # 远程代码仓库
 Contribute to the Deployer Development

 In order to help development and improve the features in Deployer,
 Deployer has a setting for usage data collection. This function
 collects anonymous usage data and sends it to Deployer. The data is
 used in Deployer development to get reliable statistics on which
 features are used (or not used). The information is not traceable
 to any individual or organization. Participation is voluntary,
 and you can change your mind at any time.

 Anonymous usage data contains Deployer version, php version, os type,
 name of the command being executed and whether it was successful or not,
 exception class name, count of hosts and anonymized project hash.

 If you would like to allow us to gather this information and help
 us develop a better tool, please add the code below.

     set('allow_anonymous_stats', true);

 This function will not affect the performance of Deployer as
 the data is insignificant and transmitted in a separate process.

 Do you confirm? (yes/no) [yes]:  # 询问是否允许 Deployer 收集匿名的部署数据以改善项目，大家根据自己的情况填入 yes 或者 no：
 > yes

Successfully created: /Users/xiaoxiao/dev/codes/php/deploy-laravel-project/deploy.php
```

将本地的 .env文件复制一份，放到 deploy.php 同一目录下然后修改配置成线上环境
编辑生成的部署脚本 deploy.php 修改成自己对应的环境
```shell
$ vim deploy.php
```
```php
<?php
namespace Deployer;

require 'recipe/laravel.php';

// Project repository
set('repository', 'https://github.com/xiaoxiao0301/shop.git');

// Shared files/dirs between deploys
add('shared_files', []);
add('shared_dirs', []);

// 内置了一个名为 deploy:copy_dirs 的任务，这个任务会遍历 copy_dirs 这个变量里的目录，然后从上一个代码版本目录里将对应的目录复制到当前目录里来
// 顺便把 composer 的 vendor 目录也加进来, 加速yarn
add('copy_dirs', ['node_modules', 'vendor']);

// Writable dirs by web server
set('writable_dirs', []);

host('阿里云公网IP')
    ->user('root') // 使用 root 账号登录
    ->identityFile('~/.ssh/laravel-shop-aliyun.pem') // 指定登录密钥文件路径
    ->become('www-data') // 以 www-data 身份执行命令
    ->set('deploy_path', '/var/www/laravel-shop-deployer'); // 指定部署目录
    
// 定义一个上传 .env 文件的任务    
desc('Upload .env file')
task('env:upload', function () {
    // 将本地的 .env 文件上传到代码目录的 .env
    upload('.env', '{{release_path}}/.env');
});

// 定义一个前端编译的任务， 项目不涉及页面的话不需要
desc('Yarn')
// release_path 是 Deployer 的一个内部变量，代表当前代码目录路径
task('deploy:yarn', function () {
    // run() 的默认超时时间是 5 分钟，而 yarn 相关的操作又比较费时，因此我们在第二个参数传入 timeout = 600，指定这个命令的超时时间是 10 分钟
    run('cd {{release_path}} && SASS_BINARY_SITE=http://npm.taobao.org/mirrors/node-sass yarn && yarn production', ['timeout' => 600]);
})

// 在 deploy:vendors 之前调用 deploy:copy_dirs
before('deploy:vendors', 'deploy:copy_dirs');

// 定义一个后置钩子，在 deploy:shared 之后执行 env:update 任务
after('deploy:shared', 'env:upload');

// 定义一个后置钩子，在 deploy:vendors 之后执行 deploy:yarn 任务
after('deploy:vendors', 'deploy:yarn');

// [Optional] if deploy fails automatically unlock.
after('deploy:failed', 'deploy:unlock');

// Deployer 的 laravel 部署脚本内已经内置了 artisan:route:cache 这个任务，前提是路由文件不能有闭包调用
after('artisan:config:cache', 'artisan:route:cache');

// Migrate database before symlink new release.

before('deploy:symlink', 'artisan:migrate');
```

执行部署命令
```shell
$ dep deploy
```
线上目录： 
/var/www/laravel-shop-deployer
current -> release/1   # 这个是软连，每部署一次，会生成一个 release/n 
release
    1
shared
    storage  # 所有版本共享 storage目录

因此线上nginx配置目录需要设置到 root  /var/www/laravel-shop-deployer/current/public


## SSH配置秘钥登陆

``shell
$ chmod 600 ~/.ssh/ssh-root.pem
$ vim ~/.ssh/config
Host IP
    PubkeyAuthentication yes
    IdentityFile ~/.ssh/ssh-root.pem
$ ssh root@IP
``

## www-data

```shell
$ sudo -H -u www-data sh -c
```



# 后台

框架： Dcat-Admin

https://learnku.com/docs/dcat-admin/2.x/install/8081

```shell
$ composer require dcat/laravel-admin:"2.*" -vvv
```

# 接口

> swagger
```shell
$ composer require "darkaonline/l5-swagger"
```
