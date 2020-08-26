{{> /tpl/header.tpl}}
{{> tpl/header.tpl}}
{{=<% %>=}}

<div id="order-list">
	<h2 class="sub-header">{{title}}</h2>
	<div class="table-responsive">
		<form action="?" method="get" id="order-form">
			<div class="form-group" id="search-oid">
				<input type="text" class="form-control" name="search_oid" v-model="search_oid" placeholder="订单号">
			</div>
			<div class="form-group" id="search-name">
				<input type="text" class="form-control" name="search_name" v-model="search_name" placeholder="商品名称">
			</div>
			<div class="form-group" id="search-status">
				<select name="search_status" v-model="search_status" class="form-control">
					<option value="">选择订单状态</option>
					<option value="WAIT_BUYER">待付款</option>
					<option value="WAIT_SELLER_SEND">待发货</option>
					<option value="WAIT_BUYER_CONFIRM">待收货</option>
				</select>
			</div>
			<div style="float:left"><button name="s" value="search" type="submit" class="btn btn-primary">搜索</button></div>
			<div style="clear:both"></div>
		</form>
		<table class="table table-hover">
			<thead>
			<tr>
				<th>订单号</th>
				<th>商品图片</th>
				<th>商品名称</th>
				<th>订单金额</th>
				<th>订单数量</th>
				<th>订单状态</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody>
				<template v-if="orders.length > 0">
				<tr v-for="order in orders">
					<td>{{order.oid}}</td>
					<td><img v-if="order.thumbnail" :src="order.thumbnail" width="130" height="130" /></td>
					<td>{{order.name}}</td>
					<td>{{order.amount}}</td>
					<td>{{order.num}}</td>
					<td v-if="order.status == 'WAIT_BUYER'">待付款</td>
					<td v-else-if="order.status == 'WAIT_SELLER_SEND'">待发货</td>
					<td v-else-if="order.status == 'WAIT_BUYER_CONFIRM'">待收货</td>
					<td v-else>"未知状态</td>
					<td>
						<a :href="'order_list.zl?act=view&amp;id='+order.id" title="查看订单详情" class="glyphicon glyphicon-eye-open" aria-hidden="true"></a>
					</td>
				</tr>
				</template>
				<tr v-else><td colspan=6>暂无订单</td></tr>
			</tbody>
		</table>
		<%={{ }}=%>
		{{> tpl/page.tpl}}
		{{=<% %>=}}
	</div>
</div>

<script type="text/javascript">
	pages = [];
	for(var i = datas.page['start']; i <= datas.page['end']; i++) {
		pages.push({
			curpage: (datas.page['curpage'] == i) ? true : false,
			page_no: i
		});
	}
	var order_list_vm = new Vue({
		el: "#order-list",
		data: {
			page_info: datas.page,
			pages: pages,
			title: datas.title,
			search_oid: datas.search_oid,
			search_name: datas.search_name,
			search_status: datas.search_status,
			orders: datas.orders
		}
	});
</script>

<%={{ }}=%>
{{> tpl/footer.tpl}}
{{> /tpl/footer.tpl}}
