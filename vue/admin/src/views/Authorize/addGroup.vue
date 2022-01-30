<template>
  <div v-loading="loading">
    <el-form ref="activityForm" :model="form" label-width="120px" style="margin-top: 10px">
      <el-input type="hidden" :id="form.id"></el-input>
      <el-form-item label="角色名称">
        <el-input v-model="form.title" class="myel-inner-item" placeholder="请输入角色名称"></el-input>
      </el-form-item>
      <el-form-item label="角色说明">
        <el-input v-model="form.remark" class="myel-inner-item" placeholder="请输入角色说明"></el-input>
      </el-form-item>
      <el-form-item label="是否启用">
        <el-radio v-model="form.status" :label="1">正常</el-radio>
        <el-radio v-model="form.status" :label="0">禁用</el-radio>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit('activityForm')" :loading="add_button_loading">提交</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getGroupInfo, addGroup, editGroup } from '@/api/authorize'

export default {
  props: {
    addCloseDialog: {
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
      add_button_loading: false,
      form: {
        id: 0,
        title: '',
        remark: '',
        status: 1,
      }
    }
  },
  mounted() {
    if (this.group_id > 0) {
      this.form.id = this.group_id
      this.getGroupInfo()
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
      if(form.id > 0) { // 编辑操作
        editGroup(form).then(response => {
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
      else { // 添加操作
        addGroup(form).then(response => {
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
    getGroupInfo() {
      this.loading = true
      getGroupInfo({id: this.form.id}).then(response => {
        let groupinfo = response.data.groupinfo
        this.form.title = groupinfo.title
        this.form.remark = groupinfo.remark
        this.form.status = groupinfo.status
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    }
  }
}
</script>
