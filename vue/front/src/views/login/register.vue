<template>
  <div class="register_wrapper">
    <el-form class="register-form" label-position="left">
      <el-form-item label="">
        <el-input v-model="form.username" placeholder="用户名"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="form.email" placeholder="邮箱"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="form.password" placeholder="密码" type="password"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="form.confirm_password" placeholder="确认密码" type="password"></el-input>
      </el-form-item>
      <el-button :loading="loading" type="primary" style="width:100%;margin-bottom:20px;" @click="register()">注 册</el-button>
    </el-form>

    <div class="link-wrapper">
      <router-link to="/login">用户登陆</router-link>
    </div>
  </div>
</template>

<script>
import { register } from '@/api/user';

export default {
  data() {
    return {
      loading: false,
      form: {
        username: '',
        email: '',
        password: '',
        confirm_password: '',
      }
    }
  },
  methods: {
    register() {
      this.loading = true
      register(this.form).then(response => {
        this.$message({
          message: response.msg,
          type: 'success'
        })
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.register-form {
  width: 40%;
  margin:0 auto;
  margin-top: 60px;
}
.link-wrapper {
  margin: 0 auto;
  width: 40%;
  a {
    color: #337ab7;
    text-decoration: none;
  }
}
</style>
