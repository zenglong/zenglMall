<div class="container" id="main-footer" v-if="!has_menus">
	<hr>
	<footer>
	<p>&copy; {{ site_name }}</p>
	</footer>
</div>

<script type="text/javascript">
	var categories = datas.categories;
	for(var index = 0; index < categories.length; index++){
		if(categories[index]['id'] == datas.top_cid)
			categories[index]['cur_cid'] = true;
		else
			categories[index]['cur_cid'] = false;
	}
	var has_menus = ((typeof menus == 'undefined') ? false : true);
	var header_navbar = new Vue({
			el: '#header-navbar',
			data: {
				site_name: datas.site_name,
				categories: datas.categories,
				has_menus: has_menus
			}
		});
	var main_footer = new Vue({
		el: "#main-footer",
		data: {
			has_menus: has_menus
		}
	});
</script>
<!-- Bootstrap core JavaScript -->
<script src="/assets/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
