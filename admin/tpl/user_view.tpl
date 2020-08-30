{{> tpl/header.tpl}}
{{=<% %>=}}

<div id="user-view">
	<h2 class="sub-header">{{title}}
		<a href="user_list.zl" class="btn btn-primary pull-right" role="button">返回列表</a>
	</h2>
	<div class="form-group">
		<label>id：</label>
		<span>{{user_info.id}}</span>
	<div class="form-group">
		<label>用户名：</label>
		<span>{{user_info.username}}</span>
	</div>
	<div class="form-group">
		<label>用户昵称：</label>
		<span v-if="user_info.nickname == ''">[未设置]</span>
		<span v-else>{{user_info.nickname}}</span>
	</div>
	<div class="form-group">
		<label>邮箱：</label>
		<span>{{user_info.email}}</span>
	</div>
	<div class="form-group">
		<label>收货人电话：</label>
		<span v-if="user_info.phone == ''">[未设置]</span>
		<span v-else>{{user_info.phone}}</span>
	</div>
	<div class="form-group">
		<label>收货人真实姓名：</label>
		<span v-if="user_info.true_name == ''">[未设置]</span>
		<span v-else>{{user_info.true_name}}</span>
	</div>
	<div class="form-group">
		<label>收货地址：</label>
		<span v-if="user_info.address == ''">[未设置]</span>
		<span v-else>{{user_info.address}}</span>
	</div>
	<div class="form-group">
		<label>注册时间：</label>
		<span>{{user_info.reg_time}}</span>
	</div>
	<div class="form-group">
		<label>更新时间：</label>
		<span>{{user_info.update_time}}</span>
	</div>
</div>

<script type="text/javascript">
	var user_view_vm = new Vue({
		el: "#user-view",
		data: {
			title: datas.title,
			user_info: datas.user_info,
		}
	});
</script>

<%={{ }}=%>
{{> tpl/footer.tpl}}
