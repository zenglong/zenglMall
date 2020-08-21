{{> /tpl/header.tpl}}
{{=<% %>=}}

<div class="container" id="register-container">
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
				<input type="text" id="username" class="form-control" placeholder="用户名" v-model="username" required autofocus>
				<label for="email" class="sr-only">邮箱</label>
				<input type="text" id="email" class="form-control" placeholder="邮箱" v-model="email" required autofocus>
				<label for="password" class="sr-only">密码</label>
				<input type="password" id="password" class="form-control" placeholder="密码" v-model="password" required>
				<label for="confirm-password" class="sr-only">确认密码</label>
				<input type="password" id="confirm-password" class="form-control" placeholder="确认密码" v-model="confirm_password" required>
				<button id="submit" @click="submit_click" class="btn btn-lg btn-danger btn-block" type="button" data-loading-text="注册中...">注 册</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var register_vm = new Vue({
		el: "#register-container",
		data: {
			title: datas.title,
			error_title: '',
			error_content: '',
			username: '',
			password: '',
			confirm_password: '',
			email: '',
			redirect: 'login.zl?redirect=' + encodeURIComponent(datas.redirect)
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
					url: "register.zl",
					dataType: "json",
					data: {
						"username": that.username,
						"email": that.email,
						"password": that.password,
						"confirm_password": that.confirm_password,
						"submit": "Submit"
					},
					beforeSend:function(){
						that.set_error('', '');
						$("#submit").button('loading');
					},
					success: function(data){
						if(data.msg == 'success') {
							$('#submit').text('注册成功 准备跳转...');
							setTimeout(function(){
								window.location = that.redirect;
							}, 1000);
						}
						else {
							that.set_error('注册失败：', data.errmsg);
							$("#submit").button('reset');
						}
					},
					//调用出错执行的函数
					error: function(err){
						that.set_error('注册失败：', '未知错误！');
						$("#submit").button('reset');
					}
				});
			}
		}
	});
</script>

<%={{ }}=%>
{{> /tpl/footer.tpl}}
