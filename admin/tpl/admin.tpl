{{=<{ }>=}}
<{> tpl/header.tpl }>

<div id="admin_main">
<h2 class="sub-header">{{all_datas.title}}</h2>
用户名：{{all_datas.username}}
昵称：{{all_datas.nickname}}

<h2 class="sub-header">配置信息: </h2>
<div class="table-responsive">
	<table class="table table-striped">
	  <thead>
		<tr>
		  <th>配置项</th>
		  <th>配置值</th>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td>mysql客户端库的版本信息</td>
			<td>{{all_datas.mysql_client_info}}</td>
		</tr>
		<tr>
			<td>mysql服务端的版本号信息</td>
			<td>{{all_datas.mysql_server_version[0] + '.' + all_datas.mysql_server_version[1] + '.' + all_datas.mysql_server_version[2]}}</td>
		</tr>
		<tr>
			<td>zenglServer版本</td>
			<td>{{all_datas.zenglServerVersion[0] + '.' + all_datas.zenglServerVersion[1] + '.' + all_datas.zenglServerVersion[2]}}</td>
		</tr>
		<tr>
			<td>zengl语言版本</td>
			<td>{{all_datas.zenglVersion[0] + '.' + all_datas.zenglVersion[1] + '.' + all_datas.zenglVersion[2]}}</td>
		</tr>
		<tr>
			<td>zenglMall版本</td>
			<td>{{all_datas.mallVersion}}</td>
		</tr>
	  </tbody>
	</table>
</div>
</div>

<script type="text/javascript">
	var admin_main_vm = new Vue({
		el: "#admin_main",
		data: {
			all_datas: datas
		}
	});
</script>

<{> tpl/footer.tpl }>
