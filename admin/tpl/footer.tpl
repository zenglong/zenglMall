</div> <!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
</div> <!-- <div class="row"> -->
</div> <!-- <div class="container-fluid"> -->

	<script type="text/javascript">
		var menus = [
			{link: "admin.zl", name: "概览"},
			{link: "user_list.zl", name: "用户列表"},
			{link: "category.zl", name: "分类列表"},
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
	<!-- Bootstrap core JavaScript -->
	<script src="/assets/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="/assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
