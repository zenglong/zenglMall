<template>
  <div class="app-container">
    <div class="search-header">
      <el-button type="primary" @click="addAttrValue()" round class="add-button">添加属性</el-button>
    </div>

    <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
      v-loading="tabLoading" :fit="true">
      <el-table-column prop="id" label="ID" width="80" align="center"></el-table-column>
      <el-table-column prop="name" label="属性值名" align="center"></el-table-column>
      <el-table-column prop="created_at" label="创建时间" align="center"></el-table-column>
      <el-table-column prop="updated_at" label="更新时间" align="center"></el-table-column>
      <el-table-column label="操作" min-width="70" align="center">
        <template slot-scope="scope">
          <i class="el-icon-edit operate-btn" @click="editAttrValue(scope.row)" title="编辑"></i>
          <i class="el-icon-delete operate-btn" @click="deleteAttrValue(scope.row)" title="删除"></i>
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
      :append-to-body="true"
      :close-on-click-modal="false"
      width="50%"
      :lock-scroll="true">
      <add-attr-value v-if="dialogVisible" @close_event="closeDialog()" 
        @close_refresh_event="closeDialog(true)" 
        @close_refresh_edit_event="closeDialog(true, true)" 
        :prop_aid="attr_id"
        :prop_id="attr_value_id"></add-attr-value>
    </el-dialog>
  </div>
</template>

<script>
import { getList, deleteAttrValue } from '@/api/goods_attr_value'
import addAttrValue from './addAttrValue'

export default {
  components: {
    addAttrValue,
  },
  props: {
    prop_attr_id: {
      type: Number,
      default: 0,
    }
  },
  data() {
    return {
      dialogTitle: '',
      tabLoading: false,
      dialogVisible: false,
      list_data: [],
      currentPage: 1,
      pageSize: 10,
      total: 0,
      attr_id: 0,
      attr_value_id: 0,
    }
  },
  mounted() {
    if(this.prop_attr_id > 0) {
      this.attr_id = this.prop_attr_id
      this.onSearchSubmit()
    }
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
    addAttrValue() {
      this.dialogTitle = '添加属性值'
      this.attr_value_id = 0
      this.dialogVisible = true
    },
    editAttrValue(row) {
      this.dialogTitle = '编辑属性值'
      this.attr_value_id = row.id
      this.dialogVisible = true
    },
    deleteAttrValue(row) {
      this.$confirm('删除['+row.name+']属性值吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.tabLoading = true
        deleteAttrValue({id: row.id}).then(response => {
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
        pageSize: this.pageSize,
        aid: this.attr_id,
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
.app-container {
  padding-top: 0;
}
.operate-btn {
 cursor: pointer;
 padding-right: 25px;
}
::v-deep .el-icon-view::before, .el-icon-edit::before, .el-icon-delete::before, .el-icon-document::before {
  font-size: 18px;
  color: #337ab7;
}
</style>
