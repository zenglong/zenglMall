{{=<% %>=}}
<nav aria-label="Page navigation">
	<ul class="pagination">
		<li>
			<a :href="page_info.link + 'page=1'" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
			</a>
		</li>
		<li>
			<a :href="page_info.link + 'page=' + page_info.prev" aria-label="Previous">
				<span aria-hidden="true">&lsaquo;</span>
			</a>
		</li>
		<li v-for="page in pages" :class="{active:page.curpage}">
			<a :href="page_info.link + 'page=' + page.page_no">{{page.page_no}}</a>
		</li>
		<li>
			<a :href="page_info.link + 'page=' + page_info.next" aria-label="Next">
				<span aria-hidden="true">&rsaquo;</span>
			</a>
		</li>
		<li>
			<a :href="page_info.link + 'page=' + page_info.totalpage" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
		</li>
	</ul>
</nav>
<span>总共{{page_info.total}}条记录/共{{page_info.totalpage}}页</span>
