{{=<{ }>=}}
<{> /tpl/header.tpl }>

<div class="container" id="login-container">
	<div class="row">
		<div class="col-xs-18 col-sm-12">
			<div class="alert alert-danger alert-dismissible err-alert" role="alert" v-if="error_title">
				<button type="button" class="close" @click="close_alert"><span aria-hidden="true">&times;</span></button>
				<strong class="err-title">{{ error_title }}</strong>
				<span class="err-content">{{ error_content }}</span>
			</div>
			<div class="form-signin">
				<h2 class="form-signin-heading" style="text-align: center;">{{ title }}</h2>
				<label for="username" class="sr-only">用户名</label>
				<input type="text" id="username" class="form-control" placeholder="用户名" required autofocus @keyup.enter="submit_click">
				<label for="password" class="sr-only">密码</label>
				<input type="password" id="password" class="form-control" placeholder="密码" required @keyup.enter="submit_click">
				<button id="submit" @click="submit_click" class="btn btn-lg btn-danger btn-block" type="button" data-loading-text="登录中...">登 录</button>
				<a :href="'register.zl?redirect=' + encodeURIComponent(redirect)">立即注册</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var login_vm = new Vue({
		el: "#login-container",
		data: {
			title: datas.title,
			error_title: '',
			error_content: '',
			redirect: datas.redirect
		},
		methods: {
			set_error: function(error_title, error_content) {
				this.error_title = error_title;
				this.error_content = error_content;
			},
			close_alert: function() {
				this.set_error('', '');
			},
			submit_click: function() {
				var that = this;
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
						that.set_error('', '');
						$("#submit").button('loading');
					},
					success: function(data){
						if(data.msg == 'success') {
							$('#submit').text('登录成功 准备跳转...');
							setTimeout(function(){
								window.location = that.redirect;
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
			}
		}
	});
</script>

<{> /tpl/footer.tpl }>
