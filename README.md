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
