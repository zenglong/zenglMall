{{> /tpl/header.tpl}}
{{> tpl/header.tpl}}
{{=<% %>=}}

<div id="order-view">
	<h2 class="sub-header">{{title}}
		<a href="order_list.zl" class="btn btn-primary pull-right" role="button">返回列表</a>
	</h2>
	<div class="form-group">
		<label>订单号：</label>
		<span>{{order_info.oid}}</span>
	</div>
	<div class="form-group" v-if="order_info.tid != ''">
		<label>支付宝交易号：</label>
		<span>{{order_info.tid}}</span>
	</div>
	<div class="form-group">
		<label>商品名称：</label>
		<span>{{order_info.name}}</span>
	</div>
	<div class="form-group" v-if="order_info.description != ''">
		<label>商品描述：</label>
		<span>{{order_info.description}}</span>
	</div>
	<div class="form-group">
		<label>商品缩略图：</label>
		<div><img v-if="order_info.thumbnail" :src="order_info.thumbnail" width="210" height="210" /></div>
	</div>
	<div class="form-group">
		<label>订单数量：</label>
		<span>{{order_info.num}}</span>
	</div>
	<div class="form-group">
		<label>订单金额：</label>
		<span>{{order_info.amount}}</span>
	</div>
	<div class="form-group">
		<label>收货人电话：</label>
		<span>{{order_info.phone}}</span>
	</div>
	<div class="form-group">
		<label>收货人真实姓名：</label>
		<span>{{order_info.true_name}}</span>
	</div>
	<div class="form-group">
		<label>收货地址：</label>
		<span>{{order_info.address}}</span>
	</div>
	<div class="form-group" v-if="order_info.buyer_remark != ''">
		<label>买家备注：</label>
		<div>{{order_info.buyer_remark}}</div>
	</div>
	<div class="form-group" v-if="order_info.seller_remark != ''">
		<label>商家备注：</label>
		<div>{{order_info.seller_remark}}</div>
	</div>
	<div class="form-group">
		<label>订单创建时间：</label>
		<span>{{order_info.create_time}}</span>
	</div>
	<div class="form-group">
		<label>订单更新时间：</label>
		<span>{{order_info.update_time}}</span>
	</div>
	<div class="form-group">
		<label>订单状态：</label>
		<span v-if="order_info.status == 'WAIT_BUYER'">待付款</span>
		<span v-else-if="order_info.status == 'WAIT_SELLER_SEND'">待发货</span>
		<span v-else-if="order_info.status == 'WAIT_BUYER_CONFIRM'">待收货</span>
		<span v-else>未知状态</span>
	</div>
	<div class="form-group" v-if="order_info.status == 'WAIT_BUYER'">
		<a :href="'order_pay.zl?id=' + order_info.id" class="btn btn-danger" target="_blank" style="width:150px">继续付款</a>
	</div>
</div>

<script type="text/javascript">
	var order_view_vm = new Vue({
		el: "#order-view",
		data: {
			title: datas.title,
			order_info: datas.order_info
		}
	});
</script>

<%={{ }}=%>
{{> tpl/footer.tpl}}
{{> /tpl/footer.tpl}}
