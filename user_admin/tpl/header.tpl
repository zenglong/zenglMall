{{=<% %>=}}
<div class="container-fluid">
<div class="row">
<div class="col-sm-3 col-md-2 sidebar" id="main-sidebar">
	<ul class="nav nav-sidebar">
		<li v-for="menu in menus" :class="{active:menu.cur_menu}">
			<a :href="menu.link">{{ menu.name }}
				<span v-if="menu.cur_menu" class="sr-only">(current)</span>
			</a>
		</li>
	</ul>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
