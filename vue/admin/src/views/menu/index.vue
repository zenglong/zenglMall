<template>
  <div class="app-container">
    <el-button-group style="margin-top: 20px; margin-left: 20px">
      <el-button type="primary" icon="el-icon-plus" @click="addMenu()">添加菜单</el-button>
    </el-button-group>
    <el-table ref="multipleTable1" border :data="menus" style="width: 96%; margin-top: 20px; margin-left: 20px"
          row-key="id"
          :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
          v-loading="tabLoading">
        <el-table-column prop="title" label="名称" width="190"></el-table-column>
        <el-table-column prop="name" label="控制器/方法" width="230"></el-table-column>
        <el-table-column prop="sort" label="排序" width="150"></el-table-column>
        <el-table-column prop="create_time" label="添加时间" width="190"></el-table-column>
        <el-table-column prop="status" label="状态" width="190">
          <template slot-scope="scope">
            <el-tag type="success" v-if="scope.row.status == 1">显示</el-tag>
            <el-tag type="warning" v-else-if="scope.row.status == 0">隐藏</el-tag>
            <el-tag type="danger" v-else>未知状态</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="290">
          <template slot-scope="scope">
            <el-button-group>
              <el-button v-if="scope.row.status == 1" size="small" icon="el-icon-close" type="default" @click="changMenuStatus(scope.row.id, 0)" style="margin-right: 3px">
                隐藏
              </el-button>
              <el-button v-else size="small" icon="el-icon-check" type="success" @click="changMenuStatus(scope.row.id, 1)" style="margin-right: 3px">
                显示
              </el-button>
              <el-button size="small" icon="el-icon-edit" type="primary" @click="editMenu(scope.row.id)" style="margin-right: 3px">
                编辑
              </el-button>
              <el-button size="small" icon="el-icon-delete" @click="delMenu(scope.row.id)" type="danger">
                删除
              </el-button>
            </el-button-group>
          </template>
        </el-table-column>
    </el-table>
    <el-dialog v-draggable class="dialogWraper" :title="dialogTitle" :visible.sync="dialogVisible"
          :close-on-click-modal="false"
          width="50%"
          :lock-scroll="true"
          @closed="dialogClosed">
      <add-menu :addCloseDialog="addCloseDialog" :menuId="menuId" :key="menuId"></add-menu>
    </el-dialog>
  </div>
</template>

<script>
import { getList, changMenuStatus, delMenu } from '@/api/menu'
import AddMenu from './AddMenu'
import DlgDraggable from "vue-element-dialog-draggable"
import Vue from 'vue'
Vue.use(DlgDraggable, {
  containment: true //Constrains dragging to within the bounds of the window.  Default: false.
})

export default {
  components: {
    AddMenu
  },
  data() {
    return {
      dialogTitle: '添加菜单',
      loading: false,
      tabLoading: false,
      dialogVisible: false,
      menus: [],
      menuId: 0,
    }
  },
  created() {
    this.loadMenuData()
  },
  methods: {
    addMenu() {
      this.dialogTitle = '添加菜单'
      this.dialogVisible = true
    },
    editMenu(id) {
      this.menuId = id
      this.dialogTitle = '编辑菜单'
      this.dialogVisible = true
    },
    delMenu(id) {
      this.$confirm('确定删除该菜单吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.tabLoading = true
        delMenu(id).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.loadMenuData()
        }).catch(error => {
          this.tabLoading = false
        })
      }).catch(() => {
      })
    },
    addCloseDialog() {
      console.log('addCloseDialog')
      this.dialogVisible = false
      this.loadMenuData()
    },
    dialogClosed() {
      this.menuId = 0
    },
    loadMenuData () {
      this.tabLoading = true
      getList().then(response => {
        this.menus = response.data.menus
        this.tabLoading = false
      }).catch(error => {
        this.tabLoading = false
      })
    },
    changMenuStatus(id, status) {
      this.tabLoading = true
      changMenuStatus({id, status}).then(response => {
        this.menus = response.data.menus
        this.tabLoading = false
      }).catch(error => {
        // this.$message.error(error)
        this.tabLoading = false
      })
    }
  }
}
</script>

<style lang="scss">
.dialogWraper .el-dialog__header:hover {
  cursor: move;
}
</style>
