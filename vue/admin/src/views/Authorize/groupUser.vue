<template>
  <div v-loading="loading">
    <el-form ref="activityForm" :model="form" label-width="120px" style="margin-top: 10px" :inline="true">
      <el-form-item label="用户UID">
        <el-input v-model="form.uids" class="myel-inner-item" placeholder="请输入用户UID，多个用英文逗号隔开"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit('activityForm')" :loading="add_button_loading">添加授权用户</el-button>
      </el-form-item>
    </el-form>

    <el-table ref="multipleTable1" border :data="list_data" style="width: 96%; margin-top: 20px; margin-left: 20px"
              v-loading="tabLoading">
        <el-table-column prop="uid" label="用户ID" width="80"></el-table-column>
        <el-table-column prop="nickname" label="用户昵称" width="180"></el-table-column>
        <el-table-column prop="status" label="状态" width="190">
          <template slot-scope="scope">
            <el-tag type="success" v-if="scope.row.status == 1">正常</el-tag>
            <el-tag type="danger" v-else>禁用</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="last_login_ip" label="最近登录IP" width="190"></el-table-column>
        <el-table-column prop="last_login_time" label="最近登录日期" width="190">
          <template slot-scope="scope">
            <span v-if="scope.row.last_login_time_orig === 0">从未登录</span>
            <span v-else>{{ scope.row.last_login_time }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="290">
          <template slot-scope="scope">
            <el-button-group>
              <el-button size="small" icon="el-icon-delete" type="danger" @click="groupUserDel(scope.row.uid)" style="margin-right: 3px">
                删除
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
  </div>
</template>

<script>
import { groupUser, groupUserAdd, groupUserDel } from '@/api/authorize'

export default {
  props: {
    groupUserCloseDialog: {
      type: Function,
      default: null
    },
    group_id: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      loading: false,
      tabLoading: false,
      add_button_loading: false,
      list_data: [],
      currentPage: 1,
      pageSize: 10,
      total: 0,
      form: {
        uids: null
      }
    }
  },
  created() {
    if(this.group_id > 0) {
      this.onSearchSubmit()
    }
  },
  methods: {
    onSubmit() {
      this.add_button_loading = true
      groupUserAdd({uids: this.form.uids, gid: this.group_id}).then(response => {
        this.$message({
          message: response.msg,
          type: 'success'
        })
        this.add_button_loading = false
        this.onSearchSubmit()
      }).catch(error => {
        this.add_button_loading = false
      })
    },
    groupUserDel(uid) {
      this.$confirm('确定移除该用户的角色授权吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true
        groupUserDel({ uid, group_id: this.group_id}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.loading = false
          this.onSearchSubmit()
        }).catch(error => {
          this.loading = false
        })
      }).catch(() => {
      });
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
      groupUser({page, pageSize, gid: this.group_id}).then(response => {
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

<style lang="scss">
  .el-pagination__total {
    margin-left: 10px;
  }
  .dialogWraper .el-dialog__header:hover {
    cursor: move;
  }
</style>
