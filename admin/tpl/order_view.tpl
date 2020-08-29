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
	<div class="form-group">
		<label>订单创建时间：</label>
		<span>{{order_info.create_time}}</span>
	</div>
	<div class="form-group">
		<label>订单更新时间：</label>
		<span>{{order_info.update_time}}</span>
	</div>
	<div class="form-group" v-if="order_info.send_time">
		<label>订单设置成待收货状态的时间：</label>
		<span>{{order_info.send_time}}</span>
	</div>
	<div class="form-group" v-if="order_info.confirm_time">
		<label>订单确认收货时间：</label>
		<span>{{order_info.confirm_time}}</span>
	</div>
	<div class="form-group">
		<label>订单状态：</label>
		<span>{{order_info_status_name}}</span>
	</div>
	<div class="form-group" v-if="order_info.buyer_remark != ''">
		<label>买家备注：</label>
		<div>{{order_info.buyer_remark}}</div>
	</div>
	<div class="form-group">
		<label>商家备注：</label>
		<div><textarea class="form-control" rows="5" id="seller-remark" v-model="seller_remark"></textarea></div>
	</div>
	<div class="form-group">
		<button id="modify-seller-remark" class="btn btn-primary" type="button" @click="modify_seller_remark" data-loading-text="设置中...">设置商家备注</button>
	</div>
	<div class="form-group" v-if="order_info.status == 'WAIT_SELLER_SEND'">
		<button id="set-send-status" class="btn btn-primary" type="button" @click="set_send_status()" data-loading-text="设置中...">设置成待收货状态</button>
	</div>
</div>

<script type="text/javascript">
	var order_view_vm = new Vue({
		el: "#order-view",
		data: {
			title: datas.title,
			order_info: datas.order_info,
			seller_remark: datas.order_info.seller_remark
		},
		computed: {
			order_info_status_name: function() {
				return get_order_status_name(null, this.order_info.status);
			}
		},
		methods: {
			modify_seller_remark: function() {
				var that = this;
				that.seller_remark = CKEDITOR.instances["seller-remark"].getData();
				$.ajax({
					type: 'POST',
					url: "order_list.zl?act=modify_seller_remark",
					dataType: "json",
					data: {
						"id": that.order_info.id,
						"seller_remark": that.seller_remark
					},
					beforeSend:function(){
						$("#modify-seller-remark").button('loading');
					},
					success: function(data){
						$("#modify-seller-remark").button('reset');
						if(data.msg == 'success') {
							alert('设置成功!');
						}
						else {
							alert('设置失败：' + data.errmsg);
						}
					},
					//调用出错执行的函数
					error: function(err){
						alert('设置失败：未知错误！');
						$("#modify-seller-remark").button('reset');
					}
				});
			},
			set_send_status: function() {
				var that = this;
				var r = confirm("是否将订单设置为待收货状态?");
				if(r !== true) {
					return ;
				}
				$.ajax({
					type: 'POST',
					url: "order_list.zl?act=set_send_status",
					dataType: "json",
					data: {
						"id": that.order_info.id
					},
					beforeSend:function(){
						$("#set-send-status").button('loading');
					},
					success: function(data){
						$("#set-send-status").button('reset');
						if(data.msg == 'success') {
							alert('设置成功!');
							window.location.reload();
						}
						else {
							alert('设置失败：' + data.errmsg);
						}
					},
					//调用出错执行的函数
					error: function(err){
						alert('设置失败：未知错误！');
						$("#set-send-status").button('reset');
					}
				});
			}
		}
	});
	CKEDITOR.replace( 'seller-remark' ,{
		height: 150,
		filebrowserUploadUrl: 'upload.zl?act=ckImage',
		filebrowserUploadMethod: 'form',
		tabSpaces: 4
	});
</script>

<%={{ }}=%>
{{> tpl/footer.tpl}}
