<template>
  <div class="app-container">
    <el-button-group style="margin-top: 20px; margin-left: 20px">
      <el-button type="primary" icon="el-icon-plus" @click="addGroup()">添加角色</el-button>
    </el-button-group>
    <el-table ref="multipleTable1" border :data="list_data" style="width: 96%; margin-top: 20px; margin-left: 20px"
              v-loading="tabLoading">
        <el-table-column prop="id" label="ID" width="80"></el-table-column>
        <el-table-column prop="title" label="角色名称" width="180"></el-table-column>
        <el-table-column prop="remark" label="说明" width="290"></el-table-column>
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
              <el-button size="small" icon="el-icon-edit" type="primary" @click="editGroup(scope.row.id)" style="margin-right: 3px">
                编辑
              </el-button>
              <el-button size="small" icon="el-icon-setting" type="success" @click="accessGroup(scope.row.id, scope.row.title)" style="margin-right: 3px">
                授权
              </el-button>
              <el-button size="small" icon="el-icon-user" type="danger" @click="groupUser(scope.row.id, scope.row.title)" style="margin-right: 3px">
                用户
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
      <add-group :addCloseDialog="addCloseDialog" :group_id="group_id" :key="group_id"></add-group>
    </el-dialog>

    <el-dialog :title="dialogAccessTitle" :visible.sync="dialogAccessVisible"
          :close-on-click-modal="false"
          width="68%"
          top="5vh"
          :lock-scroll="true"
          @closed="dialogClosed">
      <access :groupUserCloseDialog="groupUserCloseDialog" :group_id="group_id" :key="group_id"></access>
    </el-dialog>

    <el-dialog v-draggable class="dialogWraper" :title="dialogGroupUserTitle" :visible.sync="dialogGroupUserVisible"
          :close-on-click-modal="false"
          width="68%"
          :lock-scroll="true"
          @closed="dialogClosed">
      <group-user :groupUserCloseDialog="groupUserCloseDialog" :group_id="group_id" :key="group_id"></group-user>
    </el-dialog>

  </div>
</template>

<script>
import { getList } from '@/api/authorize'
import addGroup from './addGroup'
import access from './access'
import groupUser from './groupUser'
import DlgDraggable from "vue-element-dialog-draggable"
import Vue from 'vue'
Vue.use(DlgDraggable, {
  containment: true //Constrains dragging to within the bounds of the window.  Default: false.
})

export default {
  components: {
    addGroup,
    access,
    groupUser
  },
  data() {
    return {
      dialogTitle: '添加角色',
      dialogAccessTitle: '角色授权',
      dialogGroupUserTitle: '授权用户',
      loading: true,
      tabLoading: false,
      dialogVisible: false,
      dialogAccessVisible: false,
      dialogGroupUserVisible: false,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      group_id: 0,
      list_data: [],
    }
  },
  created() {
    this.onSearchSubmit()
  },
  methods: {
    showDialog(dialogTitle, dialogType, group_id = null) {
      if(group_id !== null) {
        this.group_id = group_id
      }
      if(dialogType === 1) {
        this.dialogTitle = dialogTitle
        this.dialogVisible = true
      }
      else if(dialogType === 2) {
        this.dialogAccessTitle = dialogTitle
        this.dialogAccessVisible = true
      }
      else if(dialogType === 3) {
        this.dialogGroupUserTitle = dialogTitle
        this.dialogGroupUserVisible = true
      }
    },
    addGroup() {
      this.showDialog('添加角色', 1)
    },
    editGroup(group_id) {
      this.showDialog('编辑角色', 1, group_id)
    },
    accessGroup(group_id, title) {
      this.showDialog('角色授权: ' + title, 2, group_id)
    },
    groupUser(group_id, title) {
      this.showDialog('用户授权：' + title, 3, group_id)
    },
    addCloseDialog() {
      this.dialogVisible = false
      this.loadCustomerData()
    },
    accessCloseDialog() {
      this.dialogAccessVisible = false
    },
    groupUserCloseDialog() {
      this.dialogGr
    },
    dialogClosed() {
      this.group_id = 0
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
