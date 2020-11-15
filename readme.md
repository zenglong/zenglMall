## 介绍

zenglMall是使用zengl语言开发商城系统的项目

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
zengl@zengl-ubuntu:~/zenglServer$ ./zenglServer -v
zenglServer version: v0.23.0
zengl language version: v1.8.3
zengl@zengl-ubuntu:~/zenglServer$ ./zenglServer
zengl@zengl-ubuntu:~/zenglServer$ tail -f logfile 
webroot: /home/zengl/zenglMall
session_dir: my_sessions session_expire: 1440 cleaner_interval: 3600
remote_debug_enable: False remote_debugger_ip: 127.0.0.1 remote_debugger_port: 9999 zengl_cache_enable: False shm_enable: False shm_min_size: 307200
bind done
accept sem initialized.
process_max_open_fd_num: 1024 
Master: Spawning child(0) [pid 3524] 
Master: Spawning cleaner [pid 3525] 
------------ cleaner sleep begin: 1517792159
epoll max fd count : 896 
```

假设zenglServer所在的系统的ip为10.7.20.220，那么，访问 http://10.7.20.220:8083/index.zl 可以看到商场首页

在首页顶部导航菜单，可以看到会员中心的菜单，点击该菜单可以进入到前台会员的登录界面(如果没有登录的话)，如果已经登录了，则会进入前台用户的管理界面，可以在管理界面中查看到购买的商品对应的订单列表等。

访问 http://10.7.20.220:8083/admin/login.zl 可以看到后台登录页面

zenglMall的前端页面都是用 bootstrap + jquery + vue 框架编写的

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

配置完后，访问 http://10.7.20.220:8083/install/create_table.zl 该脚本会自动在数据库中创建所需的表结构，例如 admin_users(后台管理用户表)，并在admin_users表中插入一条初始数据，该脚本执行成功后，会返回用户名，密码之类的信息，如下所示：

```
mysql客户端库的版本信息：5.7.22

mysql服务端的版本号信息：5.7.22

mysql当前设置的字符集：utf8

zenglMall版本信息：0.1.0

用户名：admin

密码：admin@123456

用户昵称：管理员

写入install.lock安装锁文件
```

安装会生成install.lock锁文件，以防止误操作，在有锁文件的情况下，执行create_table.zl脚本，会提示lock file exists，并阻止脚本继续执行

接着使用 admin 和 admin@123456 通过 http://10.7.20.220:8083/admin/login.zl 登录后台

登录成功后的后台地址：http://10.7.20.220:8083/admin/admin.zl ，后台概览页面可以看到一些基本信息，例如：mysql版本号，zenglServer版本号，zengl语言版本等等，还可以在管理后台添加分类，添加商品，以及进行订单管理等。

## 使用nginx反向代理

虽然zenglServer可以处理html，css，js之类的静态文件，但是zenglServer主要还是用于执行zengl脚本用的，静态文件只做了一些基础的支持，因此，正式上线时，需要使用nginx作为前端处理静态文件，并将zengl脚本的请求通过反向代理转发给zenglServer，这样，zenglServer就只需要处理zengl脚本即可，静态文件就可以交由nginx去处理。

下面是nginx反向代理的基本配置(这只是示例，可以根据需要调整nginx中的配置)：

```
server {
     listen 80;
     server_name mall.zengl.dev;
     root /home/zengl/zenglMall;
     index index.html index.zl;

     location ~ \.zl$ {
         proxy_pass   http://127.0.0.1:8083;
         proxy_set_header   X-real-ip $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         break;
     }
     access_log /usr/local/nginx/logs/www/zengl/mall.log jflog;
}
```

确保zenglServer对zenglMall目录有读写权限，同时nginx对zenglMall目录有读权限(让nginx能读取到静态文件即可)

使用上面nginx配置后(同时将mall.zengl.dev通过hosts之类的绑定了ip)，直接访问 http://mall.zengl.dev 就可以看到商城首页了(因为上面nginx配置的默认首页是index.zl)，访问 http://mall.zengl.dev/admin/login.zl 可以看到后台登录页面，输入用户名和密码，点击登录，可以进入到 http://mall.zengl.dev/admin/admin.zl 的后台管理页面。点击后台界面右上角的登出，可以退出登录。

如果在新版本的Chrome浏览器中 http://mall.zengl.dev 被跳转到了 https://mall.zengl.dev 的话，可以将.dev替换为.test或者.example，原因可以参考 http://blog.justwe.site/2017/12/19/chrome-redirection-https/ 或者 https://iyware.com/dont-use-dev-for-development/ 对应的文章。

要使用https访问zenglServer的话，也可以通过nginx的反向代理来实现：

```
server {
     listen 80;
     listen 443 ssl;

     ssl_certificate /usr/local/nginx/cert/mall.zengl.test.crt;
     ssl_certificate_key /usr/local/nginx/cert/mall.zengl.test.key;

     server_name mall.zengl.test;
     root /home/zengl/zenglMall;
     index index.html index.zl;

     location ~ \.zl$ {
         proxy_pass   http://127.0.0.1:8083;
         proxy_set_header   X-real-ip $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         break;
     }
     access_log /usr/local/nginx/logs/www/zengl/mall.log jflog;
}
```

## 官网

作者：zenglong

官网：www.zengl.com

