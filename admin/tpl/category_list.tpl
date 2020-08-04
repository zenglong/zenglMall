{{> tpl/header.tpl}}
{{=<% %>=}}
<h2 class="sub-header" id="sub-header">
	<template v-if="category">[{{category.name}}] </template>
	{{pid_title}}{{title}}
	<a href="?pid=-1" class="btn btn-default pull-right" role="button" style="margin-left:10px">查看所有分类</a>
	<a href="?act=add" class="btn btn-primary pull-right" role="button">添加分类</a>
</h2>
<div class="table-responsive" id="table_categories">
	<table class="table table-hover">
		<thead>
		<tr>
			<th>id</th>
			<th>分类名</th>
			<th>类型</th>
			<th>分类描述</th>
			<th>pid</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
			<template v-if="categories.length > 0">
			<tr v-for="category in categories">
				<td>{{category.id}}</td>
				<td>{{category.name}}</td>
				<td v-if="category.type == 0">普通商品分类</td>
				<td v-else-if="category.type == 1">外部链接</td>
				<td v-else>"未知类型</td>
				<td>{{category.description}}</td>
				<td>{{category.pid}}</td>
				<td>
					<template v-if="category.childcnt > 0">
						<a :href="'?pid='+category.id" :title="'查看子分类('+category.childcnt+')'" class="glyphicon glyphicon-list-alt" aria-hidden="true"></a>&nbsp;&nbsp;
					</template>
					<a :href="'?act=edit&amp;id='+category.id" title="编辑" class="glyphicon glyphicon-edit" aria-hidden="true"></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" :data-id="category.id" title="删除" class="glyphicon glyphicon-trash del_category" aria-hidden="true"></a><span></span>
				</td>
			</tr>
			</template>
			<tr v-else><td colspan=6>暂无分类或子分类</td></tr>
		</tbody>
	</table>
</div>
<script type="text/javascript">
	var sub_header_vm = new Vue({
		el: "#sub-header",
		data: {
			category: datas.category === undefined ? false : datas.category,
			pid_title: datas.pid == 0 ? "顶层" : "所有",
			title: datas.title
		}
	});
	var table_categories = new Vue({
		el: "#table_categories",
		data: {
			categories: datas.categories
		}
	});
</script>
<%={{ }}=%>
{{> tpl/footer.tpl}}
