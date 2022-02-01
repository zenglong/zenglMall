<template>
  <div class="app-container">
    <el-form :inline="true" :model="sform" class="demo-form-inline" size="small">
      <el-form-item label="">
        <el-input v-model="sform.username" placeholder="用户名" clearable></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="sform.nickname" placeholder="昵称" clearable></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="sform.email" placeholder="邮箱" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSearchSubmit()" round>查询</el-button>
      </el-form-item>
    </el-form>
    <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
              v-loading="tabLoading" :fit="true">
      <el-table-column prop="id" label="ID" width="80" align="center"></el-table-column>
      <el-table-column prop="username" label="用户名" min-width="150" align="center"></el-table-column>
      <el-table-column prop="nickname" label="昵称" min-width="150" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.nickname == ''">[未设置]</span>
          <span v-else>{{ scope.row.nickname }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="email" label="邮箱" min-width="150" align="center"></el-table-column>
      <el-table-column prop="reg_time" label="注冊时间" min-width="200" align="center"></el-table-column>
      <el-table-column label="操作" min-width="150" align="center">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click="showUserInfo(scope.row.id)" round>详情</el-button>
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
import { getUserList } from '@/api/front'

export default {
  data() {
    return {
      loading: true,
      tabLoading: false,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      list_data: [],
      sform: {
        username: '',
        nickname: '',
        email: '',
      },
    }
  },
  mounted() {
    this.onSearchSubmit()
  },
  methods: {
    showUserInfo(id) {
      this.$parent.showUserInfo(id)
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
      getUserList({page, pageSize, is_mounted,
        username: this.sform.username,
        nickname: this.sform.nickname,
        email: this.sform.email
      }).then(response => {
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