<template>
  <div class="app-container">
    <div class="search-header clearfix">
      <el-input class="search-item search-input" placeholder="订单号" v-model="sform.oid" clearable></el-input>
      <el-input class="search-item search-input" placeholder="商品名" v-model="sform.name" clearable></el-input>
      <el-input class="search-item search-input" placeholder="用户名" v-model="sform.username" clearable></el-input>
      <el-select class="search-item search-select" v-model="sform.status" placeholder="订单状态" clearable>
        <el-option
          v-for="item in all_order_status"
          :key="item.value"
          :label="item.name"
          :value="item.value">
        </el-option>
      </el-select>
      <el-button @click="onSearchSubmit()" type="primary" round>搜索</el-button>
    </div>

    <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
      v-loading="tabLoading" :fit="true">
      <el-table-column prop="oid" label="订单号" width="180" align="center"></el-table-column>
      <el-table-column prop="thumbnail" label="缩略图" width="160" align="center">
        <template slot-scope="scope">
          <img :src="scope.row.thumbnail" width="130" height="130" />
        </template>
      </el-table-column>
      <el-table-column prop="name" label="商品名" min-width="170" align="center"></el-table-column>
      <el-table-column prop="username" label="买家用户名" min-width="170" align="center"></el-table-column>
      <el-table-column prop="amount" label="订单金额" min-width="170" align="center"></el-table-column>
      <el-table-column prop="num" label="订单数量" min-width="170" align="center"></el-table-column>
      <el-table-column prop="status" label="订单状态" width="160" align="center">
        <template slot-scope="scope">
          {{get_status_name(scope.row.status) }}
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" min-width="80" align="center">
        <template slot-scope="scope">
          <i class="el-icon-view operate-btn" title="查看订单详情" @click="viewOrder(scope.row.id)"></i>
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

    <el-drawer
      title="订单详情"
      :wrapperClosable="false"
      :visible.sync="showOrderInfo"
      direction="rtl"
      size="60%">
      <order-view v-if="showOrderInfo" :order_id="order_id" :updateCallback="updateCallback"></order-view>
    </el-drawer>
  </div>
</template>

<script>
import { getList } from '@/api/order'
import { get_all_order_status, get_order_status_name } from '@/assets/js/common'
import orderView from './view'

export default {
  components: {
    orderView,
  },
  data() {
    return {
      base_url: '',
      img_base_url: '',
      tabLoading: false,
      showOrderInfo: false,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      order_id: 0,
      list_data: [],
      all_order_status: [],
      sform: {
        oid: '',
        name: '',
        username: '',
        status: '',
      }
    }
  },
  mounted() {
    this.base_url = process.env.VUE_APP_API_BASE_URL
    let last_char = this.base_url.charAt(this.base_url.length - 1)
    this.img_base_url = this.base_url
    if (last_char == '/') {
      this.img_base_url = this.base_url.substr(0, this.base_url.length-1)
    }
    this.all_order_status = get_all_order_status()
    this.onSearchSubmit(1, true)
  },
  methods: {
    updateCallback() {
      this.onSearchSubmit(this.currentPage)
    },
    viewOrder(id) {
      this.order_id = id
      this.showOrderInfo = true
    },
    get_status_name(value) {
      return get_order_status_name(this.all_order_status, value)
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
      getList({
        page, 
        pageSize, 
        is_mounted,
        oid: this.sform.oid,
        name: this.sform.name,
        username: this.sform.username,
        status: this.sform.status,
      }).then(response => {
        this.list_data = response.data.list_data
        for(let i=0;i < this.list_data.length;i++) {
          if(this.list_data[i].thumbnail.indexOf("http://") == -1) {
            this.list_data[i].thumbnail = this.img_base_url + (this.list_data[i].thumbnail ? this.list_data[i].thumbnail : 
                '/assets/image/defaultpic.jpg')
          }
        }
        this.total = response.data.total
        this.tabLoading = false
      }).catch(error => {
        this.tabLoading = false
      })
    },
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
}
::v-deep .el-icon-view::before{
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
.search-select {
  margin-right: 15px;
  ::v-deep .el-input__icon {
    line-height: 15px;
  }
}
</style>
