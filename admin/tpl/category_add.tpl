{{> tpl/header.tpl}}
{{=<% %>=}}

<div id="category_add_div">
<h2 class="sub-header">{{datas.title}}
	<a href="?act=list" class="btn btn-primary pull-right" role="button">返回列表</a>
</h2>
<div v-if="datas.err_msg" class="alert alert-danger" role="alert">{{datas.err_msg}}</div>
<div v-else-if="datas.success_msg" class="alert alert-success" role="alert">{{datas.success_msg}}</div>
<form :action="'?act=' + datas.act + (datas.id ? '&amp;id=' + datas.id : '')" method="post" id="cate_form">
	<input v-if="datas.id" type="hidden" name="id" :value="datas.id">
	<div class="form-group">
		<label for="name">分类名:</label>
		<input type="text" class="form-control" name="name" :value="datas.posts ? datas.posts.name : ''" v-once id="name" placeholder="分类名">
	</div>
	<div class="form-group">
		<label for="description">分类描述/外链地址:</label>
		<textarea class="form-control" rows="5" name="description" id="description" v-once>{{ datas.posts ? datas.posts.description: '' }}</textarea>
	</div>
	<div class="form-group">
		<label for="sel_type">类型:</label>
		<select class="form-control" id="sel_type" name="type" v-model="sel_type">
			<option value="0">普通商品分类</option>
			<option value="1">外部链接</option>
		</select>
	</div>
	<div class="form-group" id="p-cate">
		<label>上级分类:<span id="p-cate-name">{{ p_cate_name }}(pid={{ p_cate_id }})</span></label>
		<input type="hidden" name="pid" :value="p_cate_id" id="pid">
		<a v-if="datas.category" href="javascript:void(0)" id="reset_category" class="btn btn-default" @click="get_category_list(0, true)"  data-loading-text="加载分类列表...">重置上级分类</a>
		<template v-else-if="categories.length > 0">
		<select v-for="(data_categories, index) in categories" class="form-control sel_pid" @change="sel_pid_change($event, index)">
			<option value="0" data-childcnt="0">选择上级分类</option>
			<option v-for="category in data_categories" :value="category.id" :data-childcnt="category.childcnt">{{ category.name }}</option>
		</select>
		</template>
	</div>
	<div id="cate-loading" style="display:none">加载分类...</div>
	<button name="submit" value="Submit" type="submit" class="btn btn-primary">提交</button>
</form>
</div>

<script type="text/javascript">
var category_add_vm = new Vue({
	el: "#category_add_div",
	data: {
		datas: datas,
		categories: datas.categories ? [datas.categories] : [],
		sel_type: datas.posts ? datas.posts.type : 0,
		p_cate_name: datas.category ? datas.category.name : '',
		p_cate_id: datas.category ? datas.category.id : 0
	},
	methods: {
		sel_pid_change: function(event, index) {
			var option_sel = $(event.target).find("option:selected");
			var pid = option_sel.val();
			var childcnt = option_sel.data('childcnt');
			if(childcnt <= 0)
				this.categories = this.categories.slice(0, index+1);
			if(pid == 0 && index > 0) {
				option_sel = $(event.target).prev('.sel_pid').find("option:selected");
				pid = option_sel.val();
			}
			this.p_cate_id = pid;
			if(pid != 0)
				this.p_cate_name = option_sel.text();
			else
				this.p_cate_name = '';
			if(event.target.value <= 0 || childcnt <= 0)
				return ;
			this.get_category_list(index, false);
		},
		get_category_list: function(index, is_reset) {
			if(is_reset) {
				this.p_cate_name = '';
				this.p_cate_id = 0;
			}
			var that = this;
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
	}
});
</script>

<%={{ }}=%>
{{> tpl/footer.tpl}}
