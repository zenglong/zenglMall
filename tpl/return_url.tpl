{{> /tpl/header.tpl}}
{{=<% %>=}}

<div class="container" id="main-content">
	<div class="row">
		<div class="col-xs-18 col-sm-12">
			<h3>{{ msg }}</h3>
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

<%={{ }}=%>
{{> /tpl/footer.tpl}}
