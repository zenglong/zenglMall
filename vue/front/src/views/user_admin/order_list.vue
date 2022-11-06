<template>
  <div class="order-list-wrapper">
    <div class="search-header clearfix">
      <el-input class="search-item search-input" placeholder="订单号" v-model="sform.oid" clearable></el-input>
      <el-input class="search-item search-input" placeholder="商品名" v-model="sform.name" clearable></el-input>
      <el-select class="search-item search-select" v-model="sform.status" placeholder="订单状态" clearable>
        <el-option
          v-for="item in all_order_status"
          :key="item.value"
          :label="item.name"
          :value="item.value">
        </el-option>
      </el-select>
      <el-button @click="onSearchSubmit()" type="primary" round class="search-btn">搜索</el-button>
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
import { orderList } from '@/api/order'
import { get_all_order_status, get_order_status_name } from '@/assets/js/common'
import orderView from './order_view'

export default {
  components: {
    orderView,
  },
  data() {
    return {
      tabLoading: false,
      showOrderInfo: false,
      order_id: 0,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      list_data: [],
      all_order_status: [],
      sform: {
        oid: '',
        name: '',
        status: '',
      }
    }
  },
  mounted() {
    this.all_order_status = get_all_order_status()
    this.onSearchSubmit()
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
    onSearchSubmit(currentPage = 1) {
      this.currentPage = currentPage
      this.loadCustomerData(this.currentPage, this.pageSize)
    },
    loadCustomerData (page, pageSize) {
      this.tabLoading = true
      orderList({
        page, 
        pageSize,
        oid: this.sform.oid,
        name: this.sform.name,
        status: this.sform.status,
      }).then(response => {
        this.list_data = response.data.list_data
        this.total = response.data.total
        this.tabLoading = false
      }).catch(error => {
        this.tabLoading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.order-list-wrapper {
  height: 100%;
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
.search-btn {
  padding: 10px 20px;
  margin-top: 2px;
}
.operate-btn {
  cursor: pointer;
}
</style>
