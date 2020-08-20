{{> /tpl/header.tpl}}
{{=<% %>=}}

<div class="container" id="pay-info">
	<div class="row">
		<div class="col-xs-18 col-sm-12">
			<form :action="'?act=dopay' + '&amp;id=' + goods_info.id" method="post" id="pay_form">
				<div class="form-group">
					<label>当前用户: {{ user_info.username }}</label>
				</div>
				<div class="form-group">
					<label for="true_name">收货人姓名:</label>
					<input type="text" class="form-control" name="true_name" :value="user_info.true_name" v-once id="true_name" placeholder="收货人姓名">
				</div>
				<div class="form-group">
					<label for="phone">收货人电话:</label>
					<input type="text" class="form-control" name="phone" :value="user_info.phone" v-once id="phone" placeholder="收货人电话">
				</div>
				<div class="form-group">
					<label for="address">收获地址:</label>
					<textarea class="form-control" rows="20" cols="30" style="height: 150px;" name="address" id="address" v-once>{{ user_info.address }}</textarea>
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
								<td>1</td>
								<td>{{ goods_info.price }}</td>
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
	var pay_info = new Vue({
		el: '#pay-info',
		data: {
			goods_info: datas.goods_info,
			user_info: datas.user_info
		}
	});
</script>

<%={{ }}=%>
{{> /tpl/footer.tpl}}
