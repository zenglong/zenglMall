{{=<% %>=}}
<%> tpl/header.tpl %>

<div id="goods_add_div">
<h2 class="sub-header">{{datas.title}}
	<a href="?act=list" class="btn btn-primary pull-right" role="button">返回列表</a>
</h2>
<div v-if="datas.err_msg" class="alert alert-danger" role="alert">{{datas.err_msg}}</div>
<div v-else-if="datas.success_msg" class="alert alert-success" role="alert">{{datas.success_msg}}</div>
<form :action="'?act=' + datas.act + (datas.id ? '&amp;id=' + datas.id : '')" method="post" id="cate_form">
	<input v-if="datas.id" type="hidden" name="id" :value="datas.id">
	<div class="form-group">
		<label for="name">商品名称:</label>
		<input type="text" class="form-control" name="name" :value="datas.posts ? datas.posts.name : ''" v-once id="name" placeholder="商品名称">
	</div>
	<div class="form-group">
		<label for="name">商品价格:</label>
		<input type="text" class="form-control" name="price" :value="datas.posts ? datas.posts.price : ''" v-once id="name" placeholder="商品价格">
	</div>
	<div class="form-group">
		<label for="name">商品市场价格:</label>
		<input type="text" class="form-control" name="market_price" :value="datas.posts ? datas.posts.market_price : ''" v-once id="name" placeholder="商品市场价格">
	</div>
	<div class="form-group">
		<label for="store-num">商品库存:</label>
		<input type="text" class="form-control" name="store_num" :value="datas.posts ? datas.posts.store_num : ''" v-once id="store-num" placeholder="商品库存">
	</div>
	<div class="form-group">
		<label for="thumbnail-upload">商品缩略图:</label>
		<input id="thumbnail-upload" type="file" name="thumbnail_up" data-url="upload.zl?act=thumbImg">
		<input id="thumbnail-hidden" type="text" name="thumbnail" v-model="thumbnail" class="form-control"><br/>
		<span id="thumbnail-span">{{thumb_upload_text}}</span>
		<img v-if="thumbnail" :src="thumbnail" id="thumbnail-img" />
	</div>
	<div class="form-group">
		<label for="keywords">关键词:</label>
		<input type="text" class="form-control" name="keywords" :value="datas.posts ? datas.posts.keywords : ''" v-once id="keywords" placeholder="关键词">
	</div>
	<div class="form-group">
		<label for="description">描述/外链地址:</label>
		<textarea class="form-control" rows="5" name="description" id="description" v-once>{{ datas.posts ? datas.posts.description: '' }}</textarea>
	</div>
	<div class="form-group">
		<label for="content">商品详情:</label>
		<textarea class="form-control" rows="20" cols="80" name="content" id="content" v-once>{{ datas.posts ? datas.posts.content: '' }}</textarea>
	</div>
	<div class="form-group" id="p-cate">
		<label id="p-cate-label">所属分类:<span id="p-cate-name">{{ p_cate_name }}(cid={{ p_cate_id }})</span></label>
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
	<button name="submit" value="Submit" type="submit" class="btn btn-primary">提交</button>
</form>
</div>

<script type="text/javascript">
var goods_add_vm = new Vue({
	el: "#goods_add_div",
	data: {
		datas: datas,
		thumbnail: datas.posts ? datas.posts.thumbnail : '',
		thumb_upload_text: '',
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
		}
	}
});
CKEDITOR.replace( 'content' ,{
	height: 300,
	filebrowserUploadUrl: 'upload.zl?act=ckImage',
	filebrowserUploadMethod: 'form',
	tabSpaces: 4
});

// for ie10 and ie11
CKEDITOR.instances.content.setData(datas.posts ? datas.posts.content: '');

$('#thumbnail-upload').fileupload({
	dataType: 'json',
	formData: {},
	add: function(e, data) {
		goods_add_vm.thumb_upload_text = '上传中...';
		data.submit();
	},
	done: function (e, data) {
		if(typeof data.result.error === "undefined") {
			goods_add_vm.thumbnail = data.result.urlpath;
			goods_add_vm.thumb_upload_text = '';
		} else {
			goods_add_vm.thumbnail = "";
			goods_add_vm.thumb_upload_text = data.result.error;
		}
	},
	fail: function() {
		goods_add_vm.thumb_upload_text = '上传失败';
	}
});
</script>

<%> tpl/footer.tpl %>
