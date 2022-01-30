<template>
  <div class="app-container">
    <el-button-group style="margin-top: 20px; margin-left: 20px">
      <el-button type="primary" icon="el-icon-plus" @click="addMember()">添加</el-button>
    </el-button-group>
    <el-table ref="multipleTable1" border :data="list_data" style="width: 96%; margin-top: 20px; margin-left: 20px"
              v-loading="tabLoading">
        <el-table-column prop="uid" label="ID" width="80"></el-table-column>
        <el-table-column prop="username" label="用户名" width="230"></el-table-column>
        <el-table-column prop="nickname" label="昵称" width="150"></el-table-column>
        <el-table-column prop="group_name" label="角色" width="190"></el-table-column>
        <el-table-column prop="status" label="状态" width="190">
          <template slot-scope="scope">
            <el-tag type="success" v-if="scope.row.status == 1">正常</el-tag>
            <el-tag type="danger" v-else>禁用</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="update_time" label="最后更新日期" width="190"></el-table-column>
        <el-table-column label="操作" width="290">
          <template slot-scope="scope">
            <el-button-group>
              <el-button size="small" icon="el-icon-edit" type="primary" @click="editMember(scope.row.uid)" style="margin-right: 3px">
                编辑
              </el-button>
            </el-button-group>
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

    <el-dialog v-draggable class="dialogWraper" :title="dialogTitle" :visible.sync="dialogVisible"
          :close-on-click-modal="false"
          width="50%"
          :lock-scroll="true"
          @closed="dialogClosed">
      <add-member :addCloseDialog="addCloseDialog" :uid="uid" :key="uid"></add-member>
    </el-dialog>
  </div>
</template>

<script>
import { getList } from '@/api/member'
import addMember from './addMember'
import DlgDraggable from "vue-element-dialog-draggable"
import Vue from 'vue'
Vue.use(DlgDraggable, {
  containment: true //Constrains dragging to within the bounds of the window.  Default: false.
})

export default {
  components: {
    addMember
  },
  data() {
    return {
      dialogTitle: '添加用户',
      loading: true,
      tabLoading: false,
      dialogVisible: false,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      uid: 0,
      list_data: [],
    }
  },
  created() {
    this.onSearchSubmit()
  },
  methods: {
    addMember() {
      this.dialogTitle = '添加用户'
      this.dialogVisible = true
    },
    editMember(uid) {
      this.uid = uid
      this.dialogTitle = '编辑用户'
      this.dialogVisible = true
    },
    addCloseDialog() {
      console.log('addCloseDialog')
      this.dialogVisible = false
      this.loadCustomerData()
    },
    dialogClosed() {
      this.uid = 0
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
  .dialogWraper .el-dialog__header:hover {
    cursor: move;
  }
</style>
