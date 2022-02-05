<template>
  <div class="app-container">
    <div class="top-btn-wrapper clearfix">
      <el-button type="primary" class="add-button" @click="addCategory" round>添加分类</el-button>
    </div>
    <el-table ref="multipleTable1" :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px"
      row-key="id"
      :tree-props="{children: 'children'}"
      v-loading="tabLoading" :fit="true">
      <el-table-column prop="id" label="ID" min-width="80" align="center"></el-table-column>
      <el-table-column prop="name" label="分类名" min-width="150" align="center">
      </el-table-column>
      <el-table-column prop="childcnt" label="子分类数" min-width="100" align="center"></el-table-column>
      <el-table-column prop="type" label="类型" min-width="150" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.type == 0">普通分类</span>
          <span v-else-if="scope.row.type == 1">外部链接</span>
          <span v-else>未知类型</span>
        </template>
      </el-table-column>
      <el-table-column prop="description" label="描述" min-width="150" align="center"></el-table-column>
      <el-table-column label="操作" min-width="150" align="center">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click="editCategory(scope.row.id)" round>编辑</el-button>
          <el-button type="danger" size="small" @click="deleteCategory(scope.row.id, scope.row.name)" round>删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog v-draggable class="dialogWraper" :title="dialogTitle" :visible.sync="dialogVisible"
      :close-on-click-modal="false"
      width="50%"
      :lock-scroll="true"
      @closed="dialogClosed">
      <add-category :addCloseDialog="addCloseDialog" :cid="cid" :key="cid" v-if="dialogVisible"></add-category>
    </el-dialog>
  </div>
</template>

<script>
import { getList, deleteCategory } from '@/api/category'
import addCategory from './addCategory'
import DlgDraggable from "vue-element-dialog-draggable"
import Vue from 'vue'
Vue.use(DlgDraggable, {
  containment: true //Constrains dragging to within the bounds of the window.  Default: false.
})

export default {
  components: {
    addCategory
  },
  data() {
    return {
      tabLoading: false,
      dialogVisible: false,
      cid: 0,
      dialogTitle: "",
      list_data: []
    }
  },
  mounted() {
    this.getList()
  },
  methods: {
    dialogClosed() {
      this.cid = 0
    },
    addCloseDialog() {
      this.dialogVisible = false
      this.getList()
    },
    addCategory() {
      this.dialogTitle = '添加分类'
      this.dialogVisible = true
    },
    editCategory(id) {
      this.cid = id
      this.dialogTitle = '编辑分类'
      this.dialogVisible = true
    },
    deleteCategory(id, name) {
      this.$confirm('删除['+name+']分类吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.tabLoading = true
        deleteCategory({id}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          });
          this.getList()
        }).catch(error => {
          this.tabLoading = false
        })
      }).catch(() => {
      })
    },
    getList() {
      this.tabLoading = true
      getList().then(response => {
        this.list_data = response.data.categories
        this.tabLoading = false
      }).catch(error => {
        this.tabLoading = false
      })
    },
    load(tree, treeNode, resolve) {
      // console.log(tree, treeNode, resolve)
      getList({pid:tree.id}).then(response => {
        resolve(response.data.categories)
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.clearfix:after{
  visibility:hidden;
  display:block;
  font-size:0;
  content: " ";
  clear:both;
  height:0;
}
.top-btn-wrapper .add-button {
  float: right;
  margin-bottom: 10px; 
  margin-right: 20px
}
.dialogWraper {
  ::v-deep .el-dialog__header {
    border-bottom: 1px solid #e0e3e9;
  }
  ::v-deep .el-dialog__header:hover {
    cursor: move;
  }
}
</style>