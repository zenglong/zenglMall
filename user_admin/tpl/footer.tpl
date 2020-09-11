</div> <!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
</div> <!-- <div class="row"> -->
</div> <!-- <div class="container-fluid"> -->

<script type="text/javascript">
	var menus = [
		{link: "admin.zl", name: "概览"},
		{link: "order_list.zl", name: "订单列表"},
		{link: "user_info.zl", name: "修改信息"},
		{link: "password.zl", name: "修改密码"},
		{link: "logout.zl", name: "退出登录"}
	];
	for(var index = 0; index < menus.length; index++){
		if(menus[index].link == datas.cur_menu) {
			menus[index].cur_menu = true;
		}
		else {
			menus[index].cur_menu = false;
		}
	}
	var menu_vm = new Vue({
		el: '#main-sidebar',
		data: {
			menus: menus
		}
	});
</script>

