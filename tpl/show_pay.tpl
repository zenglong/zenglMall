{{=<{ }>=}}
<{> /tpl/header.tpl }>

<div class="container" id="pay-info">
	<div class="row">
		<div class="col-xs-18 col-sm-12">
			<div class="alert alert-danger alert-dismissible err-alert" role="alert" v-if="error_title">
				<button type="button" class="close" @click="close_alert"><span aria-hidden="true">&times;</span></button>
				<strong class="err-title">{{ error_title }}</strong>
				<span class="err-content">{{ error_content }}</span>
			</div>
			<form :action="'?act=dopay' + '&amp;id=' + goods_info.id + '&amp;num=' + buy_num" method="post" id="pay_form">
				<div class="form-group">
					<label>当前用户: {{ user_info.username }}</label>
				</div>
				<div class="form-group">
					<label for="true_name">收货人姓名:</label>
					<input type="text" class="form-control" name="true_name" :value="posts_data.true_name" v-once id="true_name" placeholder="收货人姓名">
				</div>
				<div class="form-group">
					<label for="phone">收货人电话:</label>
					<input type="text" class="form-control" name="phone" :value="posts_data.phone" v-once id="phone" placeholder="收货人电话">
				</div>
				<div class="form-group">
					<label for="address">收货地址:</label>
					<textarea class="form-control" rows="20" cols="30" style="height: 150px;" name="address" id="address" v-once>{{ posts_data.address }}</textarea>
				</div>
				<div class="form-group">
					<label for="buyer_remark">买家备注:</label>
					<textarea class="form-control" rows="20" cols="30" style="height: 150px;" name="buyer_remark" id="buyer_remark">{{ posts_data.buyer_remark }}</textarea>
				</div>
				<div class="form-group">
					<label for="goods-info">购买商品信息:</label>
					<table class="table">
						<thead>
						<tr>
							<th>缩略图</th>
							<th>商品名</th>
							<th>商品价格</th>
							<th>购买数量</th>
							<th>购买金额</th>
						</tr>
						</thead>
						<tbody>
							<tr>
								<td><img v-if="goods_info.thumbnail" :src="goods_info.thumbnail" width="210" height="210" /></td>
								<td>{{ goods_info.name }}</td>
								<td>{{ goods_info.price }}</td>
								<td>{{ buy_num }}</td>
								<td>{{ pay_money }}</td>
							</tr>
						</tbody>
					</table>
				</div>
				<button name="submit" value="Submit" type="submit" class="btn btn-danger" style="width:150px">确认支付</button>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	var posts_data = datas.posts_data;
	if(posts_data == '') {
		posts_data = {};
		posts_data.true_name = datas.user_info.true_name;
		posts_data.phone = datas.user_info.phone;
		posts_data.address = datas.user_info.address;
		posts_data.buyer_remark = '';
	}
	var pay_info = new Vue({
		el: '#pay-info',
		data: {
			error_title: datas.errmsg ? '错误提示：' : '',
			error_content: datas.errmsg,
			goods_info: datas.goods_info,
			user_info: datas.user_info,
			buy_num: datas.buy_num,
			pay_money: datas.pay_money,
			posts_data: posts_data
		},
		methods: {
			set_error: function(error_title, error_content) {
				this.error_title = error_title;
				this.error_content = error_content;
			},
			close_alert: function() {
				this.set_error('', '');
			}
		}
	});
</script>

<{> /tpl/footer.tpl }>
