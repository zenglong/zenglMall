<template>
  <div class="app-container">
    <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
              v-loading="tabLoading" :fit="true">
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="username" label="用户名" min-width="200"></el-table-column>
      <el-table-column prop="nickname" label="昵称" min-width="200"></el-table-column>
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
import { getAdminUserList } from '@/api/admin'

export default {
  data() {
    return {
      loading: true,
      tabLoading: false,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      list_data: [],
    }
  },
  mounted() {
    this.onSearchSubmit()
  },
  methods: {
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
      getAdminUserList({page, pageSize, is_mounted}).then(response => {
        this.list_data = response.data.list_data
        this.total = response.data.total
        this.tabLoading = false
      }).catch(error => {
        this.$message.error(error)
        this.tabLoading = false
      })
    }
  }
}
</script>