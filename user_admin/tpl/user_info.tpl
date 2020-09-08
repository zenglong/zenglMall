{{=<{ }>=}}
<{> /tpl/header.tpl }>
<{> tpl/header.tpl }>

<div id="user-info">
	<div v-if="datas.err_msg" class="alert alert-danger" role="alert">{{datas.err_msg}}</div>
	<div v-else-if="datas.success_msg" class="alert alert-success" role="alert">{{datas.success_msg}}</div>
	<form action="?act=modify" method="post" id="user_form">
		<div class="form-group">
			<label>用户名：</label>
			<span>{{user_info.username}}</span>
		</div>
		<div class="form-group">
			<label for="nickname">用户昵称:</label>
			<input type="text" class="form-control" name="nickname" :value="posts_data.nickname" v-once id="nickname" placeholder="用户昵称">
		</div>
		<div class="form-group">
			<label for="email">邮箱:</label>
			<input type="text" class="form-control" name="email" :value="posts_data.email" v-once id="email" placeholder="邮箱">
		</div>
		<div class="form-group">
			<label for="true_name">收货人真实姓名:</label>
			<input type="text" class="form-control" name="true_name" :value="posts_data.true_name" v-once id="true_name" placeholder="收货人真实姓名">
		</div>
		<div class="form-group">
			<label for="phone">收货人电话:</label>
			<input type="text" class="form-control" name="phone" :value="posts_data.phone" v-once id="phone" placeholder="收货人电话">
		</div>
		<div class="form-group">
			<label for="address">收获地址:</label>
			<textarea class="form-control" rows="20" cols="30" style="height: 150px;" name="address" id="address" v-once>{{ posts_data.address }}</textarea>
		</div>
		<button name="submit" value="Submit" type="submit" class="btn btn-danger" style="width:150px">修改信息</button>
	</form>
</div>

<script type="text/javascript">
	var posts_data = datas.posts_data;
	if(posts_data == '') {
		posts_data = {};
		posts_data.nickname = datas.user_info.nickname;
		posts_data.email = datas.user_info.email;
		posts_data.true_name = datas.user_info.true_name;
		posts_data.phone = datas.user_info.phone;
		posts_data.address = datas.user_info.address;
	}
	var user_info = new Vue({
		el: '#user-info',
		data: {
			user_info: datas.user_info,
			posts_data: posts_data
		}
	});
</script>

<{> tpl/footer.tpl }>
<{> /tpl/footer.tpl }>
