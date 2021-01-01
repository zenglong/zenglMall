{{=<{ }>=}}
<{> /tpl/header.tpl }>

<div class="container" id="main-content">
	<div class="row" v-if="sub_cate_list.length > 0">
		<div class="col-xs-18 col-sm-12 goods-list-nav">
			<div class="goods-list-nav-inner">
				<div class="goods-list-nav-label">子分类：</div>
				<div v-for="sub_cate in sub_cate_list" class="goods-list-nav-item" :class="{active:sub_cate.cur_cid}">
					<a :href="'/goods_list.zl?cid='+sub_cate.id">{{ sub_cate.name }}</a>
				</div>
				<div class="clearfloat"></div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="goods-image pull-left">
			<img v-if="goods_info.thumbnail" :src="goods_info.thumbnail" width="330" height="330"/>
		</div>
		<div class="goods-name-price pull-left">
			<div class="goods-name">{{ goods_info.name }}</div>
			<div class="goods-price">¥{{ goods_info.price }}</div>
			<div class="goods-market-price">市场价：{{ goods_info.market_price }}</div>
			<div class="goods-store-num"><input type="number" v-model="buy_num" /> 库存：{{ goods_info.store_num }}</div>
			<div class="goods-pay">
				<button @click="pay_click" id="goods-pay-btn" class="btn btn-danger pull-center" role="button">立即购买</a>
			</div>
		</div>
		<div class="clearfloat"></div>
		<div class="goods-info" v-html="goods_info.content">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-18 col-sm-12">
			<div v-if="goods_list.length > 0" class="relate-goods">相关商品：</div>
			<div v-for="goods_item in goods_list" class="index-thumbnail">
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
	var sub_cate_list = datas.sub_cate_list;
	for(var index = 0; index < sub_cate_list.length; index++){
		if(sub_cate_list[index]['id'] == datas.cate_info.id)
			sub_cate_list[index]['cur_cid'] = true;
		else
			sub_cate_list[index]['cur_cid'] = false;
	}
	var main_content = new Vue({
		el: "#main-content",
		data: {
			goods_info: datas.goods_info,
			cate_info: datas.cate_info,
			sub_cate_list: datas.sub_cate_list,
			goods_list: datas.goods_list,
			buy_num: 1
		},
		methods: {
			pay_click: function() {
				var store_num = this.goods_info.store_num;
				if(this.buy_num > store_num) {
					alert("购买数量不能超过库存，当前库存：" + store_num);
					return false;
				}
				else if(this.buy_num <= 0) {
					alert("购买数量必须大于0");
					return false;
				}
				window.location = 'goods_pay.zl?id=' + this.goods_info.id + '&num=' + this.buy_num;
			}
		}
	});
	if(datas.cate_info['pid'] == 0)
		datas.top_cid = datas.cate_info['id'];
	else
		datas.top_cid = datas.cate_info['pid'];
</script>

<{> /tpl/footer.tpl }>
