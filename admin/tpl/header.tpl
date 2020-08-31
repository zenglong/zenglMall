<!Doctype html>
{{=<{ }>=}}
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><{ title }></title>
	<!-- Bootstrap core CSS -->
	<link href="assets/css/bootstrap.min.css" rel="stylesheet">
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<link href="assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="assets/css/dashboard.css" rel="stylesheet">
	<{# csses}>
	<link href="assets/css/<{ . }>" rel="stylesheet">
	<{/ csses}>

	<script src="/assets/js/common.js?v=20200828"></script>
	<script src="/assets/js/vue.min.js"></script>
	<script src="/assets/js/jquery.min.js"></script>
	<{# head_js}>
	<script src="assets/js/<{{.}}>"></script>
	<{/ head_js}>
	<script type="text/javascript">
		var datas = <{{datas}}>;
	</script>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">zenglMall后台</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="logout.zl">登出</a></li>
			</ul>
		</div>
	</div>
</nav>

<div class="container-fluid">
<div class="row">
<div class="col-sm-3 col-md-2 sidebar" id="main-sidebar">
	<ul class="nav nav-sidebar">
		<li v-for="menu in menus" :class="{active:menu.cur_menu}">
			<a :href="menu.link">{{ menu.name }}
				<span v-if="menu.cur_menu" class="sr-only">(current)</span>
			</a>
		</li>
	</ul>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
