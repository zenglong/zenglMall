{{> /tpl/header.tpl}}
{{=<% %>=}}

<div class="container" id="main-content">
	<div class="row">
		<div class="col-xs-18 col-sm-12">
			<div v-for="item in thumb_goods" class="index-thumbnail">
				<div class="thumbnail">
					<a :href="'/goods.zl?id='+item.id" :title="item.name">
						<img :src="item.thumbnail" :alt="item.name" width="250" height="250"/>
						<div class="caption">
							<p>{{ item.name }}</p>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var main_content = new Vue({
		el: "#main-content",
		data: {
			thumb_goods: datas.thumb_goods
		}
	});
</script>

<%={{ }}=%>
{{> /tpl/footer.tpl}}
