{{> /tpl/header.tpl}}
{{=<% %>=}}

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
		<div class="col-xs-18 col-sm-12">
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
	<div class="row">
		<div class="col-xs-18 col-sm-12" style="margin-left: 15px;">
			<a href="javascript:void(0)" id="load_more" @click="get_goods_list" class="btn btn-default pull-center" role="button" data-loading-text="加载中...">加载更多商品</a>
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
			ajax_page_no: 2,
			cate_info: datas.cate_info,
			sub_cate_list: datas.sub_cate_list,
			goods_list: datas.goods_list
		},
		methods: {
			get_goods_list: function() {
				var that = this;
				$.ajax({
					type: 'GET',
					url: "goods_list.zl?timestamp="+(new Date().getTime()),
					dataType: "json",
					data: {
						"act": "ajax_page",
						"cid": that.cate_info.id,
						"page": that.ajax_page_no
					},
					beforeSend:function(){
						$("#load_more").button('loading');
					},
					success: function(data){
						if(data.length > 0) {
							for(var i=0; i < data.length;i++) {
								that.goods_list.push(data[i]);
							}
						}
						else if (data.length == 0) {
							alert("没有更多商品了!");
						}
						that.ajax_page_no++;
						$("#load_more").button('reset');
					},
					//调用出错执行的函数
					error: function(err){
						$("#load_more").button('reset');
					}
				});
			}
		}
	});

	if(datas.cate_info['pid'] == 0)
		datas.top_cid = datas.cate_info['id'];
	else
		datas.top_cid = datas.cate_info['pid'];
</script>

<%={{ }}=%>
{{> /tpl/footer.tpl}}
