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
	<div class="row" v-for="item in items">
		<a class="btn btn-primary btn-lg btn-try" :title="item.cate_name" :href="'/goods_list.zl?cid='+item.cate_id">{{ item.cate_name }}</a>
		<div class="col-xs-18 col-sm-12">
			<div v-for="goods_item in item.goods_list" class="index-thumbnail">
				<div class="thumbnail">
					<a :href="'/goods.zl?id='+goods_item.id" :title="goods_item.name">
						<img :src="goods_item.thumbnail" :alt="goods_item.name" width="300" height="300"/>
						<div class="caption">
							<p class="goods-item-price">{{ goods_item.price }}</p>
							<p class="goods-item-name">{{ goods_item.name }}</p>
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
			thumb_goods: datas.thumb_goods,
			items: datas.items
		}
	});
</script>

<%={{ }}=%>
{{> /tpl/footer.tpl}}
