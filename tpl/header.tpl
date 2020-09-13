<!Doctype html>
{{=<{ }>=}}
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><{ head_title }></title><{# keywords }>
	<meta name="keywords" content="<{ keywords }>" /><{/ keywords }>
	<{# description }><meta name="description" content="<{ description }>" /><{/ description }>
	<!-- Bootstrap core CSS -->
	<link href="/assets/css/bootstrap.min.css" rel="stylesheet">
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<link href="/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="/assets/css/common.css?v=20200815" rel="stylesheet">
	<{# csses }>
	<link href="/assets/css/<{{ . }}>" rel="stylesheet">
	<{/ csses }>

	<style type="text/css">
		#page-loading { width: 100%; height: 100%; }
		#page-loading span {
			position: absolute;
			display: block;
			font-size: 20px;
			line-height: 50px;
			top: 50%;
			left: 50%;
			width: 200px;
			height: 100px;
			-webkit-transform: translateY(-50%)  translateX(-50%);
			transform: translateY(-50%)  translateX(-50%);
		}
	</style>

	<script src="/assets/js/common.js?v=20200829"></script>
	<script src="/assets/js/vue.min.js"></script>
	<script src="/assets/js/jquery.min.js"></script>
	<{# head_js }>
	<script src="/assets/js/<{{ . }}>"></script>
	<{/ head_js }>
	<script type="text/javascript">
		var datas = <{{ datas }}>;
	</script>
</head>
<body>
<div id="page-loading">
	<span>页面加载中...</span>
</div>
<div id="page-wrapper" style="display: none">
<nav class="navbar navbar-fixed-top navbar-inverse" id="header-navbar">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/index.zl">{{ site_name }}</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li v-for="category in categories" :class="{active:category.cur_cid}">
					<a :href="'/goods_list.zl?cid='+category.id">{{category.name}}</a>
				</li>
				<li :class="{active:has_menus}"><a href="/user_admin/admin.zl">会员中心</a></li>
			</ul>
		</div><!-- /.nav-collapse -->
	</div><!-- /.container -->
</nav><!-- /.navbar -->
