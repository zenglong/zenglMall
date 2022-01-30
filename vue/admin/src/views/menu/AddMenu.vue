<template>
  <div v-loading="loading">
    <el-form ref="activityForm" :model="form" label-width="120px" style="margin-top: 10px">
      <el-input type="hidden" :id="form.id"></el-input>
      <el-form-item label="菜单名称">
        <el-input v-model="form.title" class="myel-inner-item" placeholder="请输入菜单名称"></el-input>
      </el-form-item>
      <el-form-item label="父菜单">
        <el-select v-model="form.pid" placeholder="请选择父菜单"
          filterable
          :loading="parent_loading"
          :clearable="true">
          <el-option v-for="item in parents" :key="item.id" :value="item.id" :label="item.title"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="菜单链接">
        <el-input v-model="form.name" class="myel-inner-item" placeholder="请输入菜单链接，即控制器/方法"></el-input>
      </el-form-item>
      <el-form-item label="是否显示">
        <el-switch
          v-model="form.status"
          active-text="显示"
          inactive-text="隐藏">
        </el-switch>
      </el-form-item>
      <el-form-item label="菜单排序">
        <el-input v-model="form.sort" class="myel-inner-item" placeholder="请输入菜单排序，越小越靠前"></el-input>
      </el-form-item>
      <el-form-item label="菜单排序">
        <el-radio v-model="form.type" :label="1">权限认证+菜单</el-radio>
        <el-radio v-model="form.type" :label="0">只作为菜单</el-radio>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit('activityForm')" :loading="add_button_loading">提交</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getParents, addMenu, editMenu, getMenuInfo } from '@/api/menu'

export default {
  props: {
    addCloseDialog: {
      type: Function,
      default: null
    },
    menuId: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      loading: false,
      add_button_loading: false,
      parent_loading: false,
      parents: [],
      form: {
        id: 0,
        title: '',
        name: '',
        pid: null,
        status: false,
        sort: '',
        type: 1,
      }
    }
  },
  mounted() {
    this.loadParents()
    console.log('this.menuId:', this.menuId)
    if (this.menuId > 0) {
      this.form.id = this.menuId
      this.getMenuInfo()
    }
  },
  methods: {
    closeDialog() {
      if(this.addCloseDialog) {
        this.addCloseDialog()
      }
    },
    onSubmit() {
      this.add_button_loading = true
      let form = JSON.parse(JSON.stringify(this.form))
      form.pid = form.pid ? form.pid : 0
      form.status = form.status ? 1 : 0
      if(form.id > 0) {
        editMenu(form).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.add_button_loading = false
          this.closeDialog()
        }).catch(error => {
          this.add_button_loading = false
        })
      }
      else {
        addMenu(form).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.add_button_loading = false
          this.closeDialog()
        }).catch(error => {
          this.add_button_loading = false
        })
      }
    },
    loadParents() {
      this.parent_loading = true
      getParents({get_parents: 'yes'}).then(response => {
        this.parents = response.data.menus
        this.parent_loading = false
      }).catch(error => {
        this.parent_loading = false
      })
    },
    getMenuInfo() {
      this.loading = true
      getMenuInfo({id: this.form.id}).then(response => {
        let menuinfo = response.data.menuinfo
        this.form.title = menuinfo.title
        this.form.name = menuinfo.name
        this.form.pid = menuinfo.pid
        this.form.status = menuinfo.status ? true : false,
        this.form.sort = menuinfo.sort
        this.form.type = menuinfo.type
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    }
  }
}
</script>
