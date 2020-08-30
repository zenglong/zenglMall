{{> tpl/header.tpl}}
{{=<% %>=}}

<div id="user-list">
	<h2 class="sub-header">{{title}}</h2>
	<div class="table-responsive">
		<form action="?" method="get" id="user-form">
			<div class="form-group" id="search-username">
				<input type="text" class="form-control" name="search_username" v-model="search_username" placeholder="用户名">
			</div>
			<div class="form-group" id="search-nickname">
				<input type="text" class="form-control" name="search_nickname" v-model="search_nickname" placeholder="用户昵称">
			</div>
			<div class="form-group" id="search-email">
				<input type="text" class="form-control" name="search_email" v-model="search_email" placeholder="邮箱">
			</div>
			<div style="float:left"><button name="s" value="search" type="submit" class="btn btn-primary">搜索</button></div>
			<div style="clear:both"></div>
		</form>
		<table class="table table-hover">
			<thead>
			<tr>
				<th>id</th>
				<th>用户名</th>
				<th>用户昵称</th>
				<th>邮箱</th>
				<th>注册时间</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody>
				<template v-if="users.length > 0">
				<tr v-for="user in users">
					<td>{{user.id}}</td>
					<td>{{user.username}}</td>
					<td v-if="user.nickname == ''">[未设置]</td>
					<td v-else>{{user.nickname}}</td>
					<td>{{user.email}}</td>
					<td>{{user.reg_time}}</td>
					<td>
						<a :href="'user_list.zl?act=view&amp;id='+user.id" title="查看订单详情" class="glyphicon glyphicon-eye-open" aria-hidden="true"></a>
					</td>
				</tr>
				</template>
				<tr v-else><td colspan=6>暂无用户</td></tr>
			</tbody>
		</table>
		<%={{ }}=%>
		{{> tpl/page.tpl}}
		{{=<% %>=}}
	</div>
</div>

<script type="text/javascript">
	pages = [];
	for(var i = datas.page['start']; i <= datas.page['end']; i++) {
		pages.push({
			curpage: (datas.page['curpage'] == i) ? true : false,
			page_no: i
		});
	}
	var user_list_vm = new Vue({
		el: "#user-list",
		data: {
			page_info: datas.page,
			pages: pages,
			title: datas.title,
			search_username: datas.search_username,
			search_nickname: datas.search_nickname,
			search_email: datas.search_email,
			users: datas.users
		}
	});
</script>

<%={{ }}=%>
{{> tpl/footer.tpl}}
