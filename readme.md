## 介绍

zenglMall是使用zengl语言开发商城系统的项目，下面以CentOS 7.x为例，来说明如何让zenglMall运行起来。

```
[zengl@localhost zenglServer]$ cat /etc/redhat-release
CentOS Linux release 7.7.1908 (Core)
[zengl@localhost zenglServer]$ 
```

## 配置zenglServer

首先配置zenglServer，让其网站根目录指向zenglMall：

```
................................. (zenglServer的config.zl配置，省略N行)
webroot = "/home/zengl/zenglMall"; // web根目录，指向zenglMall所在的目录

session_dir = "my_sessions"; // 会话目录
session_expire = 1440; // 会话默认超时时间(以秒为单位)，可以根据需要调整会话超时时间
session_cleaner_interval = 3600; // 会话文件清理进程的清理时间间隔(以秒为单位)
```

然后运行zenglServer(v0.1.0的zenglMall对zenglServer的最低版本要求是v0.23.0，需要开启mysql，magick，pcre以及openssl模块)：

```
[zengl@localhost zenglServer]$ ./zenglServer -v
zenglServer version: v0.23.0
zengl language version: v1.8.3
[zengl@localhost zenglServer]$ ./zenglServer
[zengl@localhost zenglServer]$ tail -f logfile -n 20
..............................................

create master process for daemon [pid:2441] 
use default config: config.zl
*** config is in debug mode ***
run config.zl complete, config: 
port: 8083 process_num: 1
webroot: /home/zengl/zenglMall
session_dir: my_sessions session_expire: 1440 cleaner_interval: 3600
remote_debug_enable: False remote_debugger_ip: 127.0.0.1 remote_debugger_port: 9999 zengl_cache_enable: False shm_enable: False shm_min_size: 307200
verbose: True request_body_max_size: 204800, request_header_max_size: 5120 request_url_max_size: 1024
URL_PATH_SIZE: 120 FULL_PATH_SIZE: 200
pidfile: zenglServer.pid
bind done
accept sem initialized.
process_max_open_fd_num: 1024 
Master: Spawning child(0) [pid 2442] 
Master: Spawning cleaner [pid 2443] 
------------ cleaner sleep begin: 1605508305
epoll max fd count : 896 
^C
[zengl@localhost zenglServer]$ ps aux | grep zenglServer
zengl     2441  0.0  0.1 145184  2324 ?        Ss   14:31   0:00 zenglServer: master[8083] cwd:/home/zengl/zenglServer -c config.zl -l logfile
zengl     2442  0.0  0.0 161576  1716 ?        Sl   14:31   0:00 zenglServer: child(0) ppid:2441
zengl     2443  0.0  0.0 145184  1712 ?        S    14:31   0:00 zenglServer: cleaner  ppid:2441
zengl     2513  0.0  0.0 112712   968 pts/0    S+   14:37   0:00 grep --color=auto zenglServer
[zengl@localhost zenglServer]$
```

如果要外网访问到，在测试环境下，可以直接关闭防火墙(正式环境则需要配置防火墙，让默认的8083端口或者zenglServer在配置文件中实际使用的端口允许通过防火墙)

```
[zengl@localhost zenglServer]$ sudo systemctl stop firewalld
[sudo] password for zengl: 
[zengl@localhost zenglServer]$ sudo systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: inactive (dead) since Mon 2020-11-16 14:37:35 CST; 30min ago
............................................
[zengl@localhost zenglServer]$ 
```

接下来，还需要启动mysql数据库服务，下面是作者的本地测试环境的启动命令：

```
[zengl@localhost zenglServer]$ sudo systemctl start mariadb
[zengl@localhost zenglServer]$ sudo systemctl status mariadb
● mariadb.service - MariaDB database server
   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2020-11-16 14:49:35 CST; 16s ago
............................................
```

下面创建数据库表结构。

## 创建数据库表结构

要进入后台管理界面，还需要创建数据库表结构，首先修改zenglMall根目录中的config.zl配置：

```
config['db_host'] = 'localhost';  // 填写mysql数据库ip
config['db_port'] = 3306;         // 填写mysql数据库端口
config['db_user'] = 'root';       // 填写mysql用户名
config['db_passwd'] = '123456';   // 填写mysql密码
config['db_name'] = 'testmall';   // 填写mysql数据库名
config['version'] = '0.1.0';      // zenglMall版本号，无需修改
config['site_name'] = 'zenglMall'; // 站点名称
config['site_desc'] = 'mall made by zengl language'; // 站点描述
// 支付宝的APPID(发起请求的应用ID)
config['app_id'] = '';
// 支付完成后的异步通知地址，必须是外网可以访问到的地址
config['notify_url'] = 'http://domain_url/notify_url.zl';
// 支付完成后跳转返回到商家的地址
config['return_url'] = 'http://domain_url/return_url.zl';
// 签名方式，目前测试脚本只支持最新的RSA2方式，所以不需要修改
config['sign_type'] = 'RSA2';
// 支付宝网关，沙箱的网关地址和正式环境的网关地址不同
config['gateway_url'] = 'https://openapi.alipaydev.com/gateway.do';
// 商户私钥
config['merchant_private_key'] = '';
// 支付宝公钥
config['alipay_public_key'] = '';
```

需要确保上面数据库配置的正确性，如果没有创建过testmall(假如你在配置中使用了testmall作为数据库名的话)，就先创建该数据库，如果要测试支付功能，则需要配置上面的支付宝的APPID，商户私钥等。

以下命令用于创建testmall数据库：

```
[zengl@localhost zenglServer]$ mysql -uroot -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 5
Server version: 5.5.64-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> create database testmall;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| testdb             |
| testmall           |
+--------------------+
5 rows in set (0.00 sec)

MariaDB [(none)]> exit
Bye
[zengl@localhost zenglServer]$ 
```

配置完并创建了数据库后，假设当前服务器的ip地址是192.168.1.113，那么访问 http://192.168.1.113:8083/install/create_table.zl 该脚本会自动在数据库中创建所需的表结构，例如 admin_users(后台管理用户表)，并在admin_users表中插入一条初始数据，该脚本执行成功后，会返回用户名，密码之类的信息，如下所示：

```
mysql客户端库的版本信息：5.5.64-MariaDB

mysql服务端的版本号信息：5.5.64

mysql当前设置的字符集：utf8

zenglMall版本信息：0.1.0

用户名：admin

密码：admin@123456

用户昵称：管理员

写入install.lock安装锁文件
```

安装会生成install.lock锁文件，以防止误操作。在有锁文件的情况下，再次执行create_table.zl脚本，就会提示 lock file exists ，并阻止脚本继续执行

安装完毕后，就可以通过 http://192.168.1.113:8083/index.zl 查看到商城的首页了，当然一开始首页的导航栏只有一个会员中心的菜单，更多的菜单需要在后台添加，页面上面也没有商品信息，也需要先在后台添加商品。

我们可以使用 admin 和 admin@123456 的初始后台管理员的用户名和密码，通过 http://192.168.1.113:8083/admin/login.zl 登录后台

登录成功后的后台地址：http://192.168.1.113:8083/admin/admin.zl ，此地址是概览页面，该页面可以看到一些基本信息，例如：mysql版本号，zenglServer版本号，zengl语言版本等等，还可以在管理后台添加分类，添加商品，以及进行订单管理等。

在后台添加商品后，如果要测试支付功能，除了要配置上面提到过的支付宝的APPID，商户私钥等配置外，还必须确保配置中的异步通知地址能被外网访问到(因为支付完成后，支付宝会将支付完成情况通过这个地址反馈给服务器，因此，ip地址或域名必须能被外网访问到)，对于本地测试环境，可以利用ngrok之类的工具，将外网请求转发到本地测试环境。

## 使用nginx反向代理

虽然zenglServer可以处理html，css，js之类的静态文件，但是zenglServer主要还是用于执行zengl脚本用的，静态文件只做了一些基础的支持，因此，正式上线时，需要使用nginx作为前端处理静态文件，并将zengl脚本的请求通过反向代理转发给zenglServer，这样，zenglServer就只需要处理zengl脚本即可，静态文件就可以交由nginx去处理。

下面是nginx反向代理的基本配置(这只是示例，可以根据需要调整nginx中的配置)：

```
server {
     listen 80;
     server_name mall.zengl.test;
     root /usr/share/nginx/html/zenglMall;
     index index.html index.zl;

     location ~ \.zl$ {
         proxy_pass   http://127.0.0.1:8083;
         proxy_set_header   X-real-ip $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         break;
     }
     access_log /var/log/nginx/mall.zengl.log;
}
```

确保zenglServer对zenglMall目录有读写权限，同时nginx对zenglMall目录有读权限(让nginx能读取到静态文件即可)

使用上面nginx配置后，直接访问 http://mall.zengl.test 就可以看到商城首页了(因为上面nginx配置的默认首页是index.zl)

访问 http://mall.zengl.test/admin/login.zl 可以看到后台登录页面。

如果要测试支付功能，请确保nginx中设置的域名能被外网访问到(否则支付宝无法将支付完成情况通过异步通知地址反馈给服务器)。

要使用https访问zenglServer的话，也可以通过nginx的反向代理来实现：

```
server {
     listen 80;
     listen 443 ssl;

     ssl_certificate /etc/nginx/ssl/mall.zengl.test.crt;
     ssl_certificate_key /etc/nginx/ssl/mall.zengl.test.key;

     server_name mall.zengl.test;
     root /usr/share/nginx/html/zenglMall;
     index index.html index.zl;

     location ~ \.zl$ {
         proxy_pass   http://127.0.0.1:8083;
         proxy_set_header   X-real-ip $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         break;
     }
     access_log /var/log/nginx/mall.zengl.log;
}
```

要测试支付功能的话，请确保nginx中设置的域名能被外网访问到，同时ssl证书是有效的证书(非自签名证书)

## 官网

作者：zenglong

官网：www.zengl.com

