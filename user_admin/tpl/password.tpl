{{=<{ }>=}}
<{> /tpl/header.tpl }>
<{> tpl/header.tpl }>

<div id="password-wrapper">
	<div v-if="datas.err_msg" class="alert alert-danger" role="alert">{{datas.err_msg}}</div>
	<div v-else-if="datas.success_msg" class="alert alert-success" role="alert">{{datas.success_msg}}</div>
	<h2 class="sub-header">{{title}}</h2>
	<form action="?act=modify" method="post" id="password-form">
		<div class="form-group">
			<label for="old_password">旧密码：</label>
			<input type="password" class="form-control" name="old_password" :value="posts_data.old_password" v-once id="old_password" placeholder="旧密码">
		</div>
		<div class="form-group">
			<label for="new_password">新密码：</label>
			<input type="password" class="form-control" name="new_password" :value="posts_data.new_password" v-once id="new_password" placeholder="新密码">
		</div>
		<div class="form-group">
			<label for="confirm_password">确认密码：</label>
			<input type="password" class="form-control" name="confirm_password" :value="posts_data.confirm_password" v-once id="confirm_password" placeholder="确认密码">
		</div>
		<button name="submit" value="Submit" type="submit" class="btn btn-danger" style="width:150px">修改密码</button>
	</form>
</div>

<script type="text/javascript">
	var posts_data = datas.posts_data;
	if(posts_data == '') {
		posts_data = {};
		posts_data.old_password = '';
		posts_data.new_password = '';
		posts_data.confirm_password = '';
	}
	var user_info = new Vue({
		el: '#password-wrapper',
		data: {
			title: datas.title,
			posts_data: posts_data
		}
	});
</script>

<{> tpl/footer.tpl }>
<{> /tpl/footer.tpl }>
