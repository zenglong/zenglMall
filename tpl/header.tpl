<!Doctype html>
{{=<% %>=}}
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><% head_title %></title><%# keywords %>
	<meta name="keywords" content="{{keywords}}" /><%/ keywords %>
	<%# description %><meta name="description" content="{{description}}" /><%/ description %>
	<!-- Bootstrap core CSS -->
	<link href="/assets/css/bootstrap.min.css" rel="stylesheet">
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<link href="/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="/assets/css/common.css" rel="stylesheet">
	<%# csses %>
	<link href="/assets/css/<% . %>" rel="stylesheet">
	<%/ csses %>

	<script src="/assets/js/vue.min.js"></script>
	<script src="/assets/js/jquery.min.js"></script>
	<%# head_js %>
	<script src="/assets/js/<%{ . }%>"></script>
	<%/ head_js %>
	<script type="text/javascript">
		var datas = <%{ datas }%>;
	</script>
</head>
<body>
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
					<a :href="'/goods.zl?act=list&amp;cid='+category.id">{{category.name}}</a>
				</li>
			</ul>
		</div><!-- /.nav-collapse -->
	</div><!-- /.container -->
</nav><!-- /.navbar -->
