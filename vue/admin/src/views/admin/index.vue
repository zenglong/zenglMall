<template>
  <div class="app-container">
    <el-table ref="multipleTable1" border :data="list_data" style="width: 96%; margin-top: 20px; margin-left: 20px"
              v-loading="tabLoading" :fit="true">
        <el-table-column prop="id" label="ID" width="80"></el-table-column>
        <el-table-column prop="user" label="用户" width="200"></el-table-column>
        <el-table-column prop="opt_time" label="时间" min-width="200"></el-table-column>
        <el-table-column prop="log" label="操作日志" min-width="190"></el-table-column>
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
import { getList } from '@/api/admin'

export default {
  data() {
    return {
      loading: true,
      tabLoading: false,
      dialogVisible: false,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      list_data: [],
      add_camp_url: 'about:blank',
      dialogTitle: '添加机构账号',
    }
  },
  created() {
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
    onSearchSubmit(currentPage = 1) {
      this.currentPage = currentPage
      this.loadCustomerData(this.currentPage, this.pageSize)
    },
    loadCustomerData (page, pageSize) {
      this.tabLoading = true
      getList({page, pageSize}).then(response => {
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

<style lang="scss" scoped>
  .el-pagination__total {
    margin-left: 10px;
  }
</style>
