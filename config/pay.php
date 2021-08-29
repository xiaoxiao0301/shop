<?php


return [
    'alipay' => [
        'app_id' => '2016101600700654',
        'ali_public_key' => 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIgHnOn7LLILlKETd6BFRJ0GqgS2Y3mn1wMQmyh9zEyWlz5p1zrahRahbXAfCfSqshSNfqOmAQzSHRVjCqjsAw1jyqrXaPdKBmr90DIpIxmIyKXv4GGAkPyJ/6FTFY99uhpiq0qadD/uSzQsefWo0aTvP/65zi3eof7TcZ32oWpwIDAQAB',
        'private_key'    => 'MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCcVGt04alVnDGWmtTEMJOBVVNRKE1tkhM+CV7vsNOmKk0LxqoUV+GRqSOBpwRNWgS03n9UdSScrGRC9X0i6RrG98cFfYrLXW/rBUNSVKlfW1i+t4TGC4AQeR36a/cxSyFSugOBz/HaToqoX5NdjcNIDeX2Kq1mKgrzpxNjiwJyT/XxtA2mYSV5w00kpOFyeLlS45SRk8Uz7DzvvyetmXnluelDdBkqXW+nfyeEz1d7wtGJODhyfNlwGXo5uUCXIxPKG5Lyrmaa+HLnn4GcZhpypz8hWOKzLQs6StlbMCOg8rwcsxW4Es2ygWBwz3lHLOzpL9d/jVqBq1MMcIC57W1lAgMBAAECggEAX7cYa+HWygHuIqX963lKdv+FGcWxUosDmRInvF3p2G1B6xnh/L6p74M9qB5YdfvNsegg0dc/aWXrpUulKIDM0lHW2ze4iTdWVPFN/NS1Nxs4xNycQJ299VgS0MbV/KphZsNZbluhWuaH4vtRwRARJsbLq+MJc+n99pyvNF1iTBZOopt5zeJUt7XcsDzHcNVfZ/0AMGH+Uh2d0zrz35VIKyIwT1tp001pvmSXqTfOBduQ47KgRVxeCgQSpXSgSLqLp61GjiBg9/ygrvDQC+2ax5vdRDIPb3fk/URq5DqPK2ZdgYowvL0uzO9IYUZD7F0QQa3eIdZIj92NK7zR3StYAQKBgQDfpDJOzaQM6ByG+U9JRX+rQsohJcs1lHBPN4ROpo4hCivDNFHWXkTebdoZ3r1+sQQNjOsIzR98BpvYxxDwPMDGiufNfRRjadEiRs1yjJKP3mLmVN3uKJSi1QMKkbmMqy50Kk3nGgnvQb2eFaSEmqUrKdepqI5idAWaoc4xZj6dAQKBgQCy8vZn4T+jQUlYIMkPWtBMb9iuUwCzHrzwr/GcuKQFD7PLLIV8hJ7RvXBKiircZHPSjJetldg+418n8HLDO9TrrxmMZr5E03yFSmoSp8W3ysxcXwFlGUEW6ratPMBotLujCisv3+a6Aq9v7JmWoVImH8T+8w1YwkmGL4sddi18ZQKBgQC88ZNTQqfMA7o+Spmy1NW1EnuFH9IcVWnBc60DafIAdgBdLnHJw+E5buPqIWZFiDZdYGYeDHcCKO84aY6k+R8BXs/Sq08zYm4/IERo99zHUeKKqL7LfFt/aqnkHxP9hY58tFUW38fu7MLPsYdKRQEwg2xiOTb6dP1bFEMJN1HFAQKBgQCZyv3CIXAT2pQyTVr++0lxp95NU8CSMKSpJk08J+OvBeO7hbPjZAcqsujC5yQW7a4tEe95nAKRac/p/1hiOhWvyHjolZSIiknGNEIdblsargwchvon7SBnlakSEdg7JLjuUlrzdjZRPuWQB4OoVVTItx0TD8g0tCWEUW/6DgrhkQKBgQCvlSb0/XUDyWvy5EOKvYSNsnt+orlDUA1wQwIcT1eTlJamvpWOEsayJX4z+APtAky7HeW6wFGp/W8nqWIyeFVdQ2mBW1+qPVBOBeNs6l8MZl6MvlGxpSAcpEpC8mUrSx8Cu+AlhAEiAV7QjDd04fRT+kmDej2+xToEqKNgA7ETRg==',
        'log'            => [
            'file' => storage_path('logs/alipay.log'),
        ],

    ],
    'wechat' => [
        'app_id'      => '',
        'mch_id'      => '',
        'key'         => '',
        'cert_client' => '',
        'cert_key'    => '',
        'log'         => [
            'file' => storage_path('logs/wechat_pay.log'),
        ],
    ],

];
