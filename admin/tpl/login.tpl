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
	<link href="assets/css/login.css" rel="stylesheet">

	<script src="/assets/js/vue.min.js"></script>
	<script src="/assets/js/jquery.min.js"></script>
</head>
<body>
	<div class="container login-container">
		<div class="alert alert-danger alert-dismissible err-alert" role="alert" v-if="error_title">
			<button type="button" class="close" @click="close_alert"><span aria-hidden="true">&times;</span></button>
			<strong class="err-title">{{ error_title }}</strong>
			<span class="err-content">{{ error_content }}</span>
		</div>
		<div class="form-signin">
			<h2 class="form-signin-heading" style="text-align: center;"><{ title }></h2>
			<label for="username" class="sr-only">用户名</label>
			<input type="text" id="username" class="form-control" placeholder="用户名" required autofocus @keyup.enter="$('#submit').click()">
			<label for="password" class="sr-only">密码</label>
			<input type="password" id="password" class="form-control" placeholder="密码" required @keyup.enter="$('#submit').click()">
			<button id="submit" class="btn btn-lg btn-primary btn-block" type="button" data-loading-text="登录中...">登 录</button>
		</div>
	</div> <!-- /container -->

	<script type="text/javascript">
	var login_vm = new Vue({
		el: '.login-container',
		data: {
			error_title: '',
			error_content: ''
		},
		methods: {
			set_error: function(error_title, error_content) {
				this.error_title = error_title;
				this.error_content = error_content;
			},
			close_alert: function() {
				this.set_error('', '');
			}
		}
	});

	$('#submit').click(function(){
		$.ajax({
			type: 'POST',
			url: "login.zl",
			dataType: "json",
			data: {
				"username": $('#username').val(),
				"password": $('#password').val(),
				"submit": "Submit"
			},
			beforeSend:function(){
				login_vm.set_error('', '');
				$("#submit").button('loading');
			},
			success: function(data){
				if(data.msg == 'success') {
					$('#submit').text('登录成功 准备跳转...');
					setTimeout(function(){
						window.location = 'admin.zl';
					}, 1000);
				}
				else {
					login_vm.set_error('登录失败：', data.errmsg);
					$("#submit").button('reset');
				}
			},
			//调用出错执行的函数
			error: function(err){
				login_vm.set_error('登录失败：', '未知错误！');
				$("#submit").button('reset');
			}
		});
	});
	</script>
	<script src="/assets/js/bootstrap.min.js"></script>
	<script src="/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

