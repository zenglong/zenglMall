npm install: 安装模块

npm run serve: 启动调试模式

npm run build: 搭建生产版本，生成dist目录

在.env.development中配置VUE_APP_API_BASE_URL即开发模式下的接口地址

在.env.production中配置VUE_APP_API_BASE_URL即生产模式下的接口地址

开发界面：

在src/views中编写控制器方法对应的视图界面

在src/permission.js中通过allowedRoutes设置允许访问的路由，需要先写界面，后配置allowedRoutes允许路由，
路由必须和src/views里的视图界面文件保持一致，包括大小写，不在allowedRoutes中的路由在访问时会显示页面未定义