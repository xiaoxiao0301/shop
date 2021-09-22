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
