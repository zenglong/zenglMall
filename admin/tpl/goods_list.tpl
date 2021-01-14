{{=<% %>=}}
<%> tpl/header.tpl %>

<h2 class="sub-header">
	商品列表
	<a href="?act=add" class="btn btn-primary pull-right" role="button">添加商品</a>
</h2>
<div class="table-responsive" id="table_goods">
	<form action="?" method="get" id="cate_form">
		<div class="form-group" id="p-title">
			<input type="text" class="form-control" name="stitle" :value="datas.stitle" v-once placeholder="标题">
		</div>
		<div class="form-group" id="p-cate">
			<label v-if="datas.category" id="p-cate-label">所属分类:<span id="p-cate-name">{{ p_cate_name }}(cid={{ p_cate_id }})</span></label>
			<input type="hidden" name="cid" :value="p_cate_id" id="pid">
			<a v-if="datas.category" href="javascript:void(0)" id="reset_category" class="btn btn-default" @click="get_category_list(0, true)"  data-loading-text="加载分类列表...">
				重置所属分类
			</a>
			<template v-else-if="categories.length > 0">
			<select v-for="(data_categories, index) in categories" class="form-control sel_pid" @change="sel_pid_change($event, index)">
				<option value="0" data-childcnt="0">选择所属分类</option>
				<option v-for="category in data_categories" :value="category.id" :data-childcnt="category.childcnt">{{ category.name }}</option>
			</select>
			</template>
			<div id="cate-loading" style="display:none">加载分类...</div>
		</div>
		<div style="float:left"><button name="s" value="search" type="submit" class="btn btn-primary">搜索</button></div>
		<div style="clear:both"></div>
	</form>
	<table class="table table-hover">
		<thead>
		<tr>
			<th>id</th>
			<th>缩略图</th>
			<th>商品名</th>
			<th width="5%">价格</th>
			<th width="5%">库存</th>
			<th width="5%">用户id</th>
			<th width="5%">分类</th>
			<th>创建时间</th>
			<th>更新时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
			<template v-if="datas.items.length > 0">
			<tr v-for="item in datas.items">
				<td>{{item.id}}</td>
				<td><img :src="item.thumbnail != '' ? item.thumbnail : '/assets/image/defaultpic.jpg'" width="130" height="130" /></td>
				<td>{{item.name}}</td>
				<td>{{item.price}}<br/><span title="市场价">({{item.market_price}})</span></td>
				<td>{{item.store_num}}</td>
				<td>{{item.uid}}</td>
				<td>{{item.cname}}</td>
				<td>{{item.created_at}}</td>
				<td>{{item.updated_at}}</td>
				<td>
					<a :href="'/goods.zl?id='+item.id" title="查看" class="glyphicon glyphicon-eye-open" aria-hidden="true" target="_blank"></a>&nbsp;&nbsp;
					<a :href="'?act=edit&amp;id='+item.id" title="编辑" class="glyphicon glyphicon-edit" aria-hidden="true"></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" :data-id="item.id" title="删除" @click="delete_goods" class="glyphicon glyphicon-trash del_category" aria-hidden="true"></a><span></span>
				</td>
			</tr>
			</template>
			<tr v-else><td colspan=10>暂无商品</td></tr>
		</tbody>
	</table>
	<nav aria-label="Page navigation">
		<ul class="pagination">
			<li>
				<a :href="datas.page.link + 'page=1'" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>
			<li>
				<a :href="datas.page.link + 'page=' + datas.page.prev" aria-label="Previous">
					<span aria-hidden="true">&lsaquo;</span>
				</a>
			</li>
			<li v-for="page in pages" :class="{active:page.curpage}">
				<a :href="datas.page.link + 'page=' + page.page_no">{{page.page_no}}</a>
			</li>
			<li>
				<a :href="datas.page.link + 'page=' + datas.page.next" aria-label="Next">
					<span aria-hidden="true">&rsaquo;</span>
				</a>
			</li>
			<li>
				<a :href="datas.page.link + 'page=' + datas.page.totalpage" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</ul>
	</nav>
	<span>总共{{datas.page.total}}个商品/共{{datas.page.totalpage}}页</span>
</div>
<script type="text/javascript">
	var table_goods = new Vue({
		el: "#table_goods",
		data: {
			datas: datas,
			pages: [],
			categories: datas.categories ? [datas.categories] : [],
			p_cate_name: datas.category ? datas.category.name : '',
			p_cate_id: datas.category ? datas.category.id : 0
		},
		methods: {
			sel_pid_change: function(event, index) {
				category_sel_pid_change(this, event, index);
			},
			get_category_list: function(index, is_reset) {
				category_get_list(this, index, is_reset);
			},
			delete_goods: function(event) {
				var id = $(event.target).data('id');
				var next_span = $(this).next('span');
				var r = confirm("删除商品确认[id: "+id+"]");
				if(r == true) {
					$.ajax({
						type: 'GET',
						url: "goods_ajax.zl?timestamp="+(new Date().getTime()),
						dataType: "json",
						data: {
							"act": "delete",
							"id": id
						},
						beforeSend:function(){
							next_span.text(' 删除中...');
						},
						success: function(data){
							if(data.msg != 'success') {					
								alert('删除失败: ' + data.errmsg);
								next_span.text('');
								return;
							}
							alert('删除成功');
							window.location.reload();
						},
						//调用出错执行的函数
						error: function(err){
							alert('未知异常');
							next_span.text('');
						}
					});
				}
			}
		}
	});
	pages = [];
	for(var i = datas.page['start']; i <= datas.page['end']; i++) {
		pages.push({
			curpage: (datas.page['curpage'] == i) ? true : false,
			page_no: i
		});
	}
	table_goods.pages = pages;
</script>

<%> tpl/footer.tpl %>
