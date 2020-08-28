function get_all_order_status()
{
	return [
		{name:'待付款', value:'WAIT_BUYER'},
		{name:'待发货', value:'WAIT_SELLER_SEND'},
		{name:'待收货', value:'WAIT_BUYER_CONFIRM'}
	];
}

function get_order_status_name(all_status, status_value)
{
	if(all_status == null)
		all_status = get_all_order_status();
	for(var i = 0; i < all_status.length;i++) {
		if(all_status[i].value == status_value) {
			return all_status[i].name;
		}
	}
	return '未知状态';
}
