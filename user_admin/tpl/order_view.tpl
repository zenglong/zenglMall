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
		<div v-html="order_info.seller_remark"></div>
	</div>
	<div class="form-group">
		<label>订单创建时间：</label>
		<span>{{order_info.create_time}}</span>
	</div>
	<div class="form-group">
		<label>订单更新时间：</label>
		<span>{{order_info.update_time}}</span>
	</div>
	<div class="form-group" v-if="order_info.send_time && order_info.status == 'WAIT_BUYER_CONFIRM'">
		<label>订单设置成待收货状态的时间：</label>
		<span>{{order_info.send_time}}</span>
	</div>
	<div class="form-group" v-else-if="order_info.confirm_time && order_info.status == 'BUYER_CONFIRM'">
		<label>订单确认收货时间：</label>
		<span>{{order_info.confirm_time}}</span>
	</div>
	<div class="form-group">
		<label>订单状态：</label>
		<span>{{order_info_status_name}}</span>
	</div>
	<div class="form-group" v-if="order_info.status == 'WAIT_BUYER'">
		<a :href="'order_pay.zl?id=' + order_info.id" class="btn btn-danger" target="_blank" style="width:150px">继续付款</a>
	</div>
	<div class="form-group" v-else-if="order_info.status == 'WAIT_BUYER_CONFIRM'">
		<button id="buyer-confirm" class="btn btn-danger" type="button" @click="buyer_confirm()" data-loading-text="操作中...">确认收货</button>
	</div>
</div>

<script type="text/javascript">
	var order_view_vm = new Vue({
		el: "#order-view",
		data: {
			title: datas.title,
			order_info: datas.order_info
		},
		computed: {
			order_info_status_name: function() {
				return get_order_status_name(null, this.order_info.status);
			}
		},
		methods: {
			buyer_confirm: function() {
				var that = this;
				var r = confirm("是否确认收货?");
				if(r !== true) {
					return ;
				}
				$.ajax({
					type: 'POST',
					url: "order_list.zl?act=buyer_confirm",
					dataType: "json",
					data: {
						"id": that.order_info.id
					},
					beforeSend:function(){
						$("#buyer-confirm").button('loading');
					},
					success: function(data){
						$("#buyer-confirm").button('reset');
						if(data.msg == 'success') {
							alert('操作成功!');
							window.location.reload();
						}
						else {
							alert('操作失败：' + data.errmsg);
						}
					},
					//调用出错执行的函数
					error: function(err){
						alert('操作失败：未知错误！');
						$("#buyer-confirm").button('reset');
					}
				});
			}
		}
	});
</script>

<%={{ }}=%>
{{> tpl/footer.tpl}}
{{> /tpl/footer.tpl}}
