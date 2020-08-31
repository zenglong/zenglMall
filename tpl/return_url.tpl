{{=<{ }>=}}
<{> /tpl/header.tpl }>

<div class="container" id="main-content">
	<div class="row">
		<div class="col-xs-18 col-sm-12">
			<h3>{{ msg }}</h3>
			<a href="/user_admin/order_list.zl">查看订单列表</a>
		</div>
	</div>
</div>

<script type="text/javascript">
	var main_content = new Vue({
		el: '#main-content',
		data: {
			msg: datas.msg
		}
	});
</script>

<{> /tpl/footer.tpl }>
