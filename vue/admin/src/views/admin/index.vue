<template>
  <div class="app-container">
    <el-descriptions class="margin-top" title="系统信息" :column="3" :size="size" border>
      <el-descriptions-item>
        <template slot="label">
          zenglServer版本
        </template>
        {{ zenglServerVersion }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template slot="label">
          zengl语言版本
        </template>
        {{ zenglVersion }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template slot="label">
          zenglMall版本
        </template>
        {{ zenglMallVersion }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template slot="label">
          mysql客户端库版本
        </template>
        {{ mysqlClientInfo }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template slot="label">
          mysql服务端版本
        </template>
        {{ mysqlServerVersion }}
      </el-descriptions-item>
    </el-descriptions>

    <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
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
      zenglServerVersion: '',
      zenglVersion: '',
      zenglMallVersion: '',
      mysqlClientInfo: '',
      mysqlServerVersion: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      size: '',
      list_data: [],
    }
  },
  mounted() {
    this.onSearchSubmit(1, true)
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
      getList({page, pageSize, is_mounted}).then(response => {
        if(is_mounted) {
          this.zenglServerVersion = response.data.zenglServerVersion[0] + '.' + 
              response.data.zenglServerVersion[1] + '.' + response.data.zenglServerVersion[2]
          this.zenglVersion = response.data.zenglVersion[0] + '.' + 
              response.data.zenglVersion[1] + '.' + response.data.zenglVersion[2]
          this.zenglMallVersion = response.data.mallVersion
          this.mysqlClientInfo = response.data.mysql_client_info
          this.mysqlServerVersion = response.data.mysql_server_version[0] + '.' +
              response.data.mysql_server_version[1] + '.' + response.data.mysql_server_version[2]
        }
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
