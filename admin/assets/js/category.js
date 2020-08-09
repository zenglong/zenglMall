function category_sel_pid_change(this_vm, event, index)
{
	var option_sel = $(event.target).find("option:selected");
	var pid = option_sel.val();
	var childcnt = option_sel.data('childcnt');
	if(childcnt <= 0)
		this_vm.categories = this_vm.categories.slice(0, index+1);
	if(pid == 0 && index > 0) {
		option_sel = $(event.target).prev('.sel_pid').find("option:selected");
		pid = option_sel.val();
	}
	this_vm.p_cate_id = pid;
	if(pid != 0)
		this_vm.p_cate_name = option_sel.text();
	else
		this_vm.p_cate_name = '';
	if(event.target.value <= 0 || childcnt <= 0)
		return ;
	category_get_list(this_vm, index, false);
}

function category_get_list(this_vm, index, is_reset) 
{
	if(is_reset) {
		this_vm.p_cate_name = '';
		this_vm.p_cate_id = 0;
	}
	var that = this_vm;
	$.ajax({
		type: 'GET',
		url: "category_ajax.zl?timestamp="+(new Date().getTime()),
		dataType: "json",
		data: {
			"act": "list",
			"pid": that.p_cate_id
		},
		beforeSend:function(){
			$("#cate-loading").show();
			if(is_reset)
				$("#reset_category").button('loading');
		},
		success: function(data){
			if(data.length > 0) {
				that.categories = that.categories.slice(0, index+1);
				that.categories.push(data);
			}
			else if (data.length == 0) {
				that.categories = [[]];
			}
			$("#cate-loading").hide();
			datas.category = null;
		},
		//调用出错执行的函数
		error: function(err){
			alert('未知异常');
			$("#cate-loading").hide();
			if(is_reset)
				$("#reset_category").button('reset');
		}
	});
}
