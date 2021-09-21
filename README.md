# 电商api实现

> 中文翻译包
```shell
$ composer require overtrue/laravel-lang
```

> jwt 认证
```shell
$ composer require tymon/jwt-auth
```

> 雪花算法
```shell
$ composer require godruoyi/php-snowflake
```

> 修改路由器的默认语法为@形式

https://laravel.com/docs/8.x/upgrade#seeder-factory-namespaces

> 短信
```shell
$ composer require overtrue/easy-sms
```

> 定时任务

使用定时任务来处理订单超时未支付问题，

支付订单后删除队列任务中记录未支付订单信息

> 通知

支付订单成功后发送站内信提示用户支付成功

> 众筹功能

与普通商品相比，众筹商品有如下特殊的业务逻辑：
- 需要设置目标金额与截止时间
- 到达截止时间时如果总订单金额低于目标金额则众筹失败，并退款所有订单 
- 到达截止时间时如果总订单金额大等于目标金额则众筹成功
- 众筹订单不支持用户主动申请退款 
- 在众筹成功之前订单不可发货

> 分期付款

- 只有当商品订单总金额高于某个数值时才可以使用分期付款；
- 用户使用分期付款时，需要选择还款期限，通常为 3 个月的倍数；
- 使用分期付款需要支付手续费，不同的还款期限手续费费率不同，还款期限越久费率越高；
- 分期付款的手续费与银行贷款的利息不同，银行贷款的利息会随着还款而逐渐降低，而分期付款的手续费则是固定的；
- 使用分期付款后，用户需要立即支付第一期的费用，当第一期费用支付成功后，对应的商品订单状态即变为已支付；
- 用户需每 30 天还款一次，如果在还款截止日期之后仍未还款，需支付逾期费，逾期费按天计算；
- 逾期之后产生的逾期费用最多不超过当期的本金 + 手续费；
- 每一期还款金额计算公式：(本金 + 手续费) / 还款期数 + 当期逾期费；
- 使用了分期付款的商品订单如果发生退款，则退回所有已支付的本金，手续费与逾期费不退回。

> 金额计算

```shell
$ composer require brick/math
```

> Elasticsearch

```shell
$ composer require elasticsearch/elasticsearch
```


```shell
$ docker pull elasticsearch:7.14.1
$ docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms200m -Xmx200m" elasticsearch:7.14.1
```
> 安装 analysis-ik 中文分词插件

```shell
$ docker exec -it es /bin/bash
# ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.14.1/elasticsearch-analysis-ik-7.14.1.zip
```

> 拷贝配置文件到本地

```shell
$ cd elasticsearch7
$ docker cp es:/usr/share/elasticsearch/config ./
$ docker cp es:/usr/share/elasticsearch/data ./
$ docker cp es:/usr/share/elasticsearch/plugins ./
```
> 编辑配置文件

vim jvm.options

-Xms200m
-Xmx200m

vim elasticsearch.yml

node.name: master
http.cors.enabled: true
http.cors.allow-origin: "*"
network.host: 0.0.0.0


> 重启docker

```shell
$ docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -v /Users/xiaoxiao/dev/server/elasticsearch7/config:/usr/share/elasticsearch/config -v /Users/xiaoxiao/dev/server/elasticsearch7/data:/usr/share/elasticsearch/data -v /Users/xiaoxiao/dev/server/elasticsearch7/plugins://usr/share/elasticsearch/plugins elasticsearch:7.14.1
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
