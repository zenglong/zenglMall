<template>
  <div>
    <el-form class="password-form">
      <el-form-item label="旧密码" class="my-form-item">
        <el-input v-model="info.old_password" placeholder="旧密码" type="password"></el-input>
      </el-form-item>
      <el-form-item label="新密码" class="my-form-item">
        <el-input v-model="info.new_password" placeholder="新密码" type="password"></el-input>
      </el-form-item>
      <el-form-item label="确认密码" class="my-form-item">
        <el-input v-model="info.confirm_password" placeholder="确认密码" type="password"></el-input>
      </el-form-item>
      <el-button :loading="modify_loading" type="primary" style="width:150px;margin-bottom:20px;" @click="modifyPassword()">修改密码</el-button>
    </el-form>
  </div>
</template>

<script>
import { modifyPassword } from '@/api/user'

export default {
  data() {
    return {
      modify_loading: false,
      info: {
        old_password: '',
        new_password: '',
        confirm_password: '',
      }
    }
  },
  methods: {
    modifyPassword() {
      this.modify_loading = true
      modifyPassword({
        old_password: this.info.old_password,
        new_password: this.info.new_password,
        confirm_password: this.info.confirm_password,
      }).then(response => {
        this.$message({
          message: response.msg,
          type: 'success'
        })
        this.modify_loading = false
      }).catch(error => {
        this.modify_loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.my-form-item {
  ::v-deep .el-input__inner {
    width: 80%;
  }
  ::v-deep .el-textarea__inner {
    width: 80%;
  }
}
</style>
