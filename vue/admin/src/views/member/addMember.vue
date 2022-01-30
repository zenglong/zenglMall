<template>
  <div v-loading="loading">
    <el-form ref="activityForm" :model="form" label-width="120px" style="margin-top: 10px">
      <el-input type="hidden" :id="form.uid"></el-input>
      <el-form-item label="用户名">
        <el-input v-model="form.username" class="myel-inner-item" placeholder="请输入用户名"></el-input>
      </el-form-item>
      <el-form-item label="用户昵称">
        <el-input v-model="form.nickname" class="myel-inner-item" placeholder="请输入用户昵称"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input placeholder="请输入密码" v-model="form.password" show-password></el-input>
        <div>请填写6到12位密码<span v-if="uid > 0"> (如果不修改密码，留空即可)</span></div>
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
import { getUserInfo, addMember, editMember } from '@/api/member'

export default {
  props: {
    addCloseDialog: {
      type: Function,
      default: null
    },
    uid: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      loading: false,
      add_button_loading: false,
      form: {
        uid: 0,
        username: '',
        nickname: '',
        password: '',
        status: 1,
      }
    }
  },
  mounted() {
    if (this.uid > 0) {
      this.form.uid = this.uid
      this.getUserInfo()
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
      if(form.uid > 0) { // 编辑操作
        editMember(form).then(response => {
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
        addMember(form).then(response => {
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
    getUserInfo() {
      this.loading = true
      getUserInfo({uid: this.form.uid}).then(response => {
        let userinfo = response.data.userinfo
        this.form.username = userinfo.username
        this.form.nickname = userinfo.nickname
        // this.form.password = userinfo.password
        this.form.password = ''
        this.form.status = userinfo.status
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    }
  }
}
</script>
