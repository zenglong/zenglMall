<template>
  <div class="app-container">
    <div class="search-header">
      <el-button type="primary" @click="addAttr()" round class="add-button">添加属性</el-button>
    </div>

    <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
      v-loading="tabLoading" :fit="true">
      <el-table-column prop="id" label="ID" width="80" align="center"></el-table-column>
      <el-table-column prop="name" label="属性名" align="center"></el-table-column>
      <el-table-column prop="created_at" label="创建时间" align="center"></el-table-column>
      <el-table-column prop="updated_at" label="更新时间" align="center"></el-table-column>
      <el-table-column label="操作" min-width="70" align="center">
        <template slot-scope="scope">
          <i class="el-icon-edit operate-btn" @click="editAttr(scope.row)" title="编辑"></i>
          <i class="el-icon-document operate-btn" @click="attrValueList(scope.row)" title="属性值"></i>
          <i class="el-icon-delete operate-btn" @click="deleteAttr(scope.row)" title="删除"></i>
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
      :lock-scroll="true">
      <add-attr v-if="dialogVisible" @close_event="closeDialog()" 
        @close_refresh_event="closeDialog(true)" 
        @close_refresh_edit_event="closeDialog(true, true)" 
        :prop_attr_id="attr_id"></add-attr>
    </el-dialog>
  </div>
</template>

<script>
import { getList, deleteAttr } from '@/api/goods_attr'
import addAttr from './addAttr'
import DlgDraggable from "vue-element-dialog-draggable"
import Vue from 'vue'
Vue.use(DlgDraggable, {
  containment: true //Constrains dragging to within the bounds of the window.  Default: false.
})

export default {
  components: {
    addAttr
  },
  data() {
    return {
      dialogTitle: '',
      dialogVisible: false,
      tabLoading: false,
      attr_id: 0,
      list_data: [],
      currentPage: 1,
      pageSize: 10,
      total: 0,
    }
  },
  mounted() {
    this.onSearchSubmit()
  },
  methods: {
    closeDialog(refresh = false, is_edit = false) {
      this.dialogVisible = false
      if(refresh) {
        if(is_edit) {
          this.onSearchSubmit(this.currentPage)
        }
        else {
          this.onSearchSubmit()
        }
      }
    },
    addAttr() {
      this.dialogTitle = '添加属性'
      this.attr_id = 0
      this.dialogVisible = true
    },
    editAttr(row) {
      this.dialogTitle = '编辑属性'
      this.attr_id = row.id
      this.dialogVisible = true
    },
    deleteAttr(row) {
      this.$confirm('删除['+row.name+']属性吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.tabLoading = true
        deleteAttr({id: row.id}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          });
          this.onSearchSubmit(this.currentPage)
        }).catch(error => {
          this.tabLoading = false
        })
      }).catch(() => {
      })
    },
    attrValueList(row) {
      // TODO
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
      this.loadCustomerData(this.currentPage)
    },
    loadCustomerData (page) {
      this.tabLoading = true
      getList({
        page,
        pageSize: this.pageSize
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
.operate-btn {
 cursor: pointer;
 padding-right: 25px;
}
::v-deep .el-icon-view::before, .el-icon-edit::before, .el-icon-delete::before, .el-icon-document::before {
  font-size: 18px;
  color: #337ab7;
}
</style>
