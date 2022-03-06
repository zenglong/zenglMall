<template>
  <div class="app-container">
    <div class="search-header">
      <el-input class="search-item search-input" placeholder="商品名" v-model="sform.name" clearable></el-input>
      <el-cascader :options="categories" 
        class="search-item search-cid"
        v-model="sform.cid"
        clearable
        :props="{ checkStrictly: true, value: 'id', label: 'name' }"
        :loading="category_loading"></el-cascader>
      <el-button @click="onSearchSubmit()" type="primary" round>搜索</el-button>
      <el-button type="primary" @click="addGoods()" round class="add-button">添加商品</el-button>
    </div>

    <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
      v-loading="tabLoading" :fit="true">
      <el-table-column prop="id" label="ID" width="80" align="center"></el-table-column>
      <el-table-column prop="thumbnail" label="缩略图" width="160" align="center">
        <template slot-scope="scope">
          <img :src="base_url + '' + (scope.row.thumbnail ? scope.row.thumbnail : 'assets/image/defaultpic.jpg')" width="130" height="130" />
        </template>
      </el-table-column>
      <el-table-column prop="name" label="商品名" min-width="170" align="center"></el-table-column>
      <el-table-column prop="name" label="价格" min-width="90" align="center">
        <template slot-scope="scope">
          <span>{{scope.row.price}}</span><br/>
          <span title="市场价">({{scope.row.market_price}})</span>
        </template>
      </el-table-column>
      <el-table-column prop="store_num" label="库存" min-width="90" align="center"></el-table-column>
      <el-table-column prop="uid" label="用户ID" min-width="90" align="center"></el-table-column>
      <el-table-column prop="cname" label="分类名" min-width="90" align="center"></el-table-column>
      <el-table-column prop="created_at" label="创建时间" width="100" align="center"></el-table-column>
      <el-table-column prop="updated_at" label="更新时间" width="100" align="center"></el-table-column>
      <el-table-column label="操作" min-width="150" align="center">
        <template>
          <i class="el-icon-view operate-btn" title="查看"></i>
          <i class="el-icon-edit operate-btn" title="编辑"></i>
          <i class="el-icon-delete operate-btn" title="删除"></i>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-sizes="[10, 20, 30, 40, 50, 60, 70, 80, 90]"
      :page-size="pageSize"
      layout="prev, pager, next, jumper, total, sizes"
      :total="total"
      style="margin-top:10px;margin-left:15px">
    </el-pagination>
  </div>
</template>

<script>
import { getList } from '@/api/goods'
import { getList as getCategoryList } from '@/api/category'

export default {
  data() {
    return {
      base_url: '',
      tabLoading: false,
      category_loading: false,
      categories: [],
      currentPage: 1,
      pageSize: 10,
      total: 0,
      list_data: [],
      sform: {
        name: '',
        cid: null,
      }
    }
  },
  mounted() {
    this.base_url = process.env.VUE_APP_API_BASE_URL
    this.onSearchSubmit(1, true)
    this.getCategoryList()
  },
  methods: {
    addGoods() {
      this.$router.replace('/goods/addGoods')
    },
    handleSizeChange(val) {
      this.currentPage = 1
      this.pageSize = val
      this.onSearchSubmit()
    },
    handleCurrentChange(val) {
      this.currentPage = val
      this.onSearchSubmit(val)
    },
    onSearchSubmit(currentPage = 1, is_mounted = false) {
      this.currentPage = currentPage
      this.loadCustomerData(this.currentPage, this.pageSize, is_mounted)
    },
    loadCustomerData (page, pageSize, is_mounted = false) {
      this.tabLoading = true
      let cid = null
      if(this.sform.cid && this.sform.cid.length > 0) {
        cid = this.sform.cid[this.sform.cid.length - 1]
      }
      getList({
        page, 
        pageSize, 
        is_mounted,
        name: this.sform.name,
        cid: cid
      }).then(response => {
        this.list_data = response.data.list_data
        this.total = response.data.total
        this.tabLoading = false
      }).catch(error => {
        this.tabLoading = false
      })
    },
    getCategoryList() {
      this.category_loading = true
      getCategoryList().then(response => {
        this.categories = response.data.categories
        this.category_loading = false
      }).catch(error => {
        this.category_loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.clearfix:after{
  visibility:hidden;
  display:block;
  font-size:0;
  content: " ";
  clear:both;
  height:0;
}
.operate-btn {
 cursor: pointer;
 padding-right: 15px;
}
::v-deep .el-icon-view::before, .el-icon-edit::before, .el-icon-delete::before {
  font-size: 20px;
  color: #337ab7;
}
.search-item {
  width: 220px;
  float:left;
  margin-top: 3px;
  ::v-deep .el-input__inner {
    width: 220px;
    height: 35px;
    line-height: 35px;
    border-radius: 36px;
  }
}
.search-input {
  margin-right: 15px;
}
.search-cid {
  margin-right: 15px;
}
.search-cid.el-cascader {
  line-height: 35px;
}
.add-button {
  float: right;
}
</style>
