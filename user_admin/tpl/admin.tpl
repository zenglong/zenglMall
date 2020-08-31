{{=<{ }>=}}
<{> /tpl/header.tpl }>
<{> tpl/header.tpl }>

<div id="admin_main">
	<h2 class="sub-header">{{title}}</h2>
	用户名：{{user_info.username}}<br/>
	邮 箱：{{user_info.email}}
</div>

<script type="text/javascript">
	var admin_main = new Vue({
		el: "#admin_main",
		data: {
			title: datas.title,
			user_info: datas.user_info
		}
	});
</script>

<{> tpl/footer.tpl }>
<{> /tpl/footer.tpl }>
