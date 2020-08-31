{{=<{ }>=}}
<{> tpl/header.tpl }>

<div id="userlist_main">
<h2 class="sub-header">{{all_datas.title}}</h2>
<div class="table-responsive">
	<table class="table table-striped">
		<thead>
		<tr>
			<th>id</th>
			<th>用户名</th>
			<th>用户昵称</th>
		</tr>
		</thead>
		<tbody>
			<tr v-for="user in all_datas.users">
				<td>{{user.id}}</td>
				<td>{{user.username}}</td>
				<td>{{user.nickname}}</td>
			</tr>
		</tbody>
	</table>
</div>
</div>

<script type="text/javascript">
	var admin_main_vm = new Vue({
		el: "#userlist_main",
		data: {
			all_datas: datas
		}
	});
</script>

<{> tpl/footer.tpl }>
